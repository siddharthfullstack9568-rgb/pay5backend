class Api::V1::Agent::EnquiresController < ApplicationController
  skip_before_action :verify_authenticity_token

  # -----------------------------------
  # CREATE ENQUIRY + USER + SERVICES
  # -----------------------------------
  def create

    # Generate OTP
    otp = rand(100000..999999).to_s

    ActiveRecord::Base.transaction do

      # -----------------------------------
      # CREATE ENQUIRY
      # -----------------------------------
      enquiry = Enquiry.new(
        enquiry_params.merge(
          status: false
        )
      )

      case params[:id_proof]
      when "Aadhaar"
        enquiry.aadhaar_number = params[:id_number]

      when "Pancard"
        enquiry.pan_card = params[:id_number]
      end

      unless enquiry.save
        return render json: {
          code: 422,
          message: "Failed to create enquiry",
          errors: enquiry.errors.full_messages
        }, status: :unprocessable_entity
      end

      # -----------------------------------
      # CREATE USER
      # -----------------------------------
      user = User.new(
        first_name: enquiry.first_name,
        last_name: enquiry.last_name,
        email: enquiry.email,
        phone_number: enquiry.phone_number,
        role_id: enquiry.role_id,
        aadhaar_number: enquiry.aadhaar_number,
        pan_card: enquiry.pan_card,

        # Username
        username: enquiry.email.split("@").first,

        # Temporary Password
        password: "Temp@123",
        password_confirmation: "Temp@123",

        # OTP DATA
        email_otp: otp,
        email_otp_status: false,
        email_otp_verified_at: 10.minutes.from_now,

        # ACCOUNT STATUS
        status: false
      )

      unless user.save
        return render json: {
          code: 422,
          message: "User creation failed",
          errors: user.errors.full_messages
        }, status: :unprocessable_entity
      end

      # -----------------------------------
      # ASSIGN ALL SERVICES
      # -----------------------------------
      Service.find_each do |service|

        UserService.find_or_create_by!(
            assigner_id: 2,
            assignee_id: user.id,
            service_id: service.id
          )

      end

      # -----------------------------------
      # SEND OTP MAIL
      # -----------------------------------
      Thread.new do
        begin
          ActiveRecord::Base.connection_pool.with_connection do
            EnquiryMailer.send_enquiry_otp(
              user,
              otp
            ).deliver_now
          end
        rescue => e
          Rails.logger.error(
            "Failed to send enquiry OTP: #{e.message}"
          )
        end
      end

      render json: {
        code: 201,
        message: "Enquiry, User and Services created successfully. OTP sent to email.",
        enquiry: enquiry,
        user: user
      }, status: :created
    end
  end

  # -----------------------------------
  # VERIFY EMAIL OTP
  # -----------------------------------
  def verify_email

    user = User.find_by(
      email: params[:email].to_s.strip.downcase
    )

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
        message: "OTP expired. Please request new OTP."
      }
    end

    # OTP Match
    if user.email_otp == params[:otp].to_s.strip

      # -----------------------------------
      # GENERATE REAL PASSWORD
      # -----------------------------------
      generated_password = SecureRandom.hex(4)

      user.update!(
        password: generated_password,
        password_confirmation: generated_password,

        email_otp_status: true,
        email_otp: nil,
        email_otp_verified_at: Time.current,

        status: true
      )

      # -----------------------------------
      # UPDATE ENQUIRY STATUS
      # -----------------------------------
      enquiry = Enquiry.find_by(email: user.email)

      enquiry.update!(
        status: true
      ) if enquiry.present?

      # -----------------------------------
      # SEND LOGIN CREDENTIALS MAIL
      # -----------------------------------
      Thread.new do
        begin
          ActiveRecord::Base.connection_pool.with_connection do
            EnquiryMailer.send_user_credentials(
              user,
              generated_password
            ).deliver_now
          end
        rescue => e
          Rails.logger.error(
            "Failed to send credentials email: #{e.message}"
          )
        end
      end

      return render json: {
        code: 200,
        message: "Email verified successfully. Password sent to email.",
        user: user
      }
    end

    render json: {
      code: 401,
      message: "Invalid OTP"
    }
  end

  private

  def enquiry_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :aadhaar_number,
      :pan_card,
      :role_id
    )
  end
end