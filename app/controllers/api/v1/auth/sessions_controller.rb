class Api::V1::Auth::SessionsController < Api::V1::Auth::BaseController
  skip_before_action :authorize_request, only: [
    :login,
    :verify_email,
    :create,
    :verify_registration_email
  ]

  # ------------------------------------
  # LOGIN (Admin + Master + Dealer + Agent)
  # ------------------------------------
  def login
    login_param = params[:email].to_s.strip.downcase

    user = User.find_by(
      "LOWER(email) = ? OR LOWER(username) = ?",
      login_param,
      login_param
    )

    enquiry = Enquiry.find_by(email: params[:email].to_s.strip)

    # User not verified yet
    if enquiry.present? && !enquiry.status
      return render json: {
        code: 200,
        message: "Please wait, admin will verify you"
      }
    end

    # Invalid user
    unless user
      return render json: {
        code: 401,
        message: "Invalid email or password"
      }
    end

    # User inactive
    unless user.status
      return render json: {
        code: 200,
        message: "Please wait, admin will verify your account",
        user: user
      }
    end

    # Password check
    unless user.authenticate(params[:password])
      return render json: {
        code: 401,
        message: "Invalid email or password"
      }
    end

    # Allowed roles
    allowed_roles = %w[admin master dealer retailer individual]

    unless allowed_roles.include?(user.role.title)
      return render json: {
        code: 403,
        message: "Role not allowed"
      }
    end

    # Generate OTP
    otp = rand(100000..999999).to_s

    user.update!(
      email_otp: otp,
      email_otp_status: false,
      email_otp_verified_at: 10.minutes.from_now
    )

    # Send OTP Mail
    Thread.new do
      begin
        ActiveRecord::Base.connection_pool.with_connection do
          UserMailer.send_email_otp(user, otp).deliver_now
        end
      rescue => e
        Rails.logger.error("Failed to send OTP email: #{e.message}")
      end
    end

    render json: {
      code: 200,
      message: "OTP sent to your email",
      user: user
    }
  end

  # ------------------------------------
  # VERIFY LOGIN EMAIL OTP
  # ------------------------------------
  def verify_email
    user = User.find_by(email: params[:email].to_s.strip)

    unless user
      return render json: {
        code: 404,
        message: "User not found"
      }
    end

    # OTP Expired
    if user.email_otp_verified_at.nil? ||
       Time.current > user.email_otp_verified_at

      return render json: {
        code: 401,
        message: "OTP expired. Please request new."
      }
    end

    # OTP Match
    if user.email_otp == params[:otp].to_s.strip

      user.update!(
        email_otp_status: true,
        email_otp: nil,
        email_otp_verified_at: Time.current
      )

      # JWT Token
      token = JsonWebToken.encode(
        user_id: user.id,
        role: user.role.title.capitalize
      )

      return render json: {
        code: 200,
        message: "Email verified successfully",
        token: token,
        role: {
          title: user.role.title.capitalize
        },
        user: user
      }
    end

    render json: {
      code: 401,
      message: "Invalid OTP"
    }
  end

  # ------------------------------------
  # CREATE USER
  # ------------------------------------
  def create
    user = User.new(
      retailer_params.merge(
        status: false,
        email_verified: false
      )
    )

    case params[:id_proof]
    when "Aadhaar"
      user.aadhaar_number = params[:id_number]

    when "Pancard"
      user.pan_card = params[:id_number]
    end

    # Generate OTP
    otp = rand(100000..999999).to_s

    user.email_otp = otp
    user.email_otp_status = false
    user.email_otp_verified_at = 10.minutes.from_now

    if user.save

      # Send Verification Mail
      Thread.new do
        begin
          ActiveRecord::Base.connection_pool.with_connection do
            UserMailer.send_registration_otp(user, otp).deliver_now
          end
        rescue => e
          Rails.logger.error("Failed to send registration OTP: #{e.message}")
        end
      end

      render json: {
        code: 201,
        message: "User created successfully. OTP sent to email.",
        user: user
      }

    else
      render json: {
        code: 422,
        message: "Failed",
        errors: user.errors.full_messages
      }
    end
  end

  # ------------------------------------
  # VERIFY REGISTRATION EMAIL
  # ------------------------------------
  def verify_registration_email
    user = User.find_by(email: params[:email].to_s.strip)

    unless user
      return render json: {
        code: 404,
        message: "User not found"
      }
    end

    # OTP Expired
    if user.email_otp_verified_at.nil? ||
       Time.current > user.email_otp_verified_at

      return render json: {
        code: 401,
        message: "OTP expired"
      }
    end

    # OTP Match
    if user.email_otp == params[:otp].to_s.strip

      user.update!(
        email_verified: true,
        email_otp_status: true,
        email_otp: nil,
        email_otp_verified_at: Time.current
      )

      return render json: {
        code: 200,
        message: "Registration email verified successfully",
        user: user
      }
    end

    render json: {
      code: 401,
      message: "Invalid OTP"
    }
  end

  # ------------------------------------
  # ROLE LIST
  # ------------------------------------
  def role
    roles = Role.all

    render json: {
      code: 200,
      message: "Role List",
      roles: roles
    }
  end

  private

  # ------------------------------------
  # STRONG PARAMS
  # ------------------------------------
  def retailer_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password,
      :role_id,
      :country_code,
      :alternative_number,
      :aadhaar_number,
      :pan_card,
      :date_of_birth,
      :gender,
      :business_name,
      :business_owner_type,
      :business_nature_type,
      :business_registration_number,
      :gst_number,
      :pan_number,
      :address,
      :city,
      :state,
      :pincode,
      :landmark,
      :username,
      :scheme,
      :referred_by,
      :bank_name,
      :account_number,
      :ifsc_code,
      :account_holder_name,
      :notes
    )
  end
end