class Api::V1::Auth::SessionsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token
  skip_before_action :authorize_request, only: [:login, :verify_email, :create]

  # ------------------------------------
  # LOGIN (Admin + Master + Dealer + Agent)
  # ------------------------------------
  def login
    p "============check"
    user = User.find_by(email: params[:email].to_s.strip)
    p "==========user"
    p user
    enquiry = Enquiry.find_by(email: params[:email].to_s.strip)

    # User not verified yet
    if enquiry.present? && !enquiry.status
      return render json: { code: 200, message: "Please wait, admin will verify you" }
    end

    # Invalid user
    unless user
      return render json: { code: 401, message: "Invalid email or password" }
    end

    # User inactive
    unless user.status
      return render json: { code: 200, message: "Please wait, admin will verify your account", user: user}
    end

    # Password check
    unless user.authenticate(params[:password])
      return render json: { code: 401, message: "Invalid email or password" }
    end

    # Allowed roles
    allowed_roles = %w[admin master dealer retailer]
    unless allowed_roles.include?(user.role.title)
      return render json: { code: 403, message: "Role not allowed" }
    end

    # OTP generate
    otp = rand(100000..999999).to_s

    user.update!(
      email_otp: otp,
      email_otp_status: false,
      email_otp_verified_at: 10.minutes.from_now
    )

    # Send OTP
    UserMailer.send_email_otp(user, otp).deliver_now

    render json: {
      code: 200,
      message: "OTP sent to your email",
      user: user
    }
  end

  # ------------------------------------
  # VERIFY EMAIL OTP
  # ------------------------------------
  def verify_email
    user = User.find_by(email: params[:email].to_s.strip)

    unless user
      return render json: { code: 404, message: "User not found" }
    end

    # OTP Expired
    if user.email_otp_verified_at.nil? || Time.current > user.email_otp_verified_at
      return render json: { code: 401, message: "OTP expired. Please request new." }
    end

    # OTP match?
    if user.email_otp == params[:otp].to_s.strip

      user.update!(
        email_otp_status: true,
        email_otp: nil,
        email_otp_verified_at: Time.current
      )

      # Generate JWT Token WITH CORRECT ROLE
      token = JsonWebToken.encode(
        user_id: user.id,
        role: user.role.title  # <===== FIX HERE
      )

      return render json: {
        code: 200,
        message: "Email verified successfully",
        token: token,
        role: { title: user.role.title },   # <===== FIX HERE
        user: user
      }
    end

    # Wrong OTP
    render json: { code: 401, message: "Invalid OTP" }
  end


  # ------------------------------------
  # CREATE NEW USER (Retailer / Dealer etc)
  # ------------------------------------
  def create
    user = User.new(retailer_params.merge(status: false)) # status false = waiting for approval

    case params[:id_proof]
    when "Aadhaar"
      user.aadhaar_number = params[:id_number]
    when "Pancard"
      user.pan_card = params[:id_number]
    end

    if user.save
      render json: { code: 201, message: "User created successfully", user: user }
    else
      render json: { code: 422, message: "Failed", errors: user.errors.full_messages }
    end
  end

  # ------------------------------------
  # ROLE LIST
  # ------------------------------------
  def role
    roles = Role.all
    render json: { code: 200, message: "Role List", roles: roles }
  end

  private

  # STRONG PARAMS
  def retailer_params
    params.permit(
      :first_name, :last_name, :email, :phone_number, :password,
      :role_id, :country_code, :alternative_number,
      :aadhaar_number, :pan_card, :date_of_birth, :gender,
      :business_name, :business_owner_type, :business_nature_type,
      :business_registration_number, :gst_number, :pan_number,
      :address, :city, :state, :pincode, :landmark,
      :username, :scheme, :referred_by,
      :bank_name, :account_number, :ifsc_code,
      :account_holder_name, :notes
    )
  end
end
