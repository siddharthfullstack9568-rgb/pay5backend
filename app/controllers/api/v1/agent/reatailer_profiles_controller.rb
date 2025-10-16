# app/controllers/api/v1/agent/reatailer_profiles_controller.rb
module Api
  module V1
    module Agent
      class ReatailerProfilesController < Api::V1::Agent::BaseController
        protect_from_forgery with: :null_session

        def index
          render json: { code: 200,message: "Users fetched successfully",users: current_user }, status: :ok
        end

        def set_pin
          if params[:set_pin].present? && params[:confirm_pin].present?
            if params[:set_pin] == params[:confirm_pin]
              current_user.update!(set_pin: params[:set_pin], confirm_pin: params[:confirm_pin])
              render json: { code: 200, message: "Successfully set pin" }
            else
              render json: { code: 422, message: "Pin and confirm pin do not match" }
            end
          else
            render json: { code: 400, message: "Pin and confirm pin are required" }
          end
        end

        def set_mpin
          if params[:set_mpin].present? && params[:confirm_mpin].present?
            if params[:set_mpin] == params[:confirm_mpin]
              current_user.update!(set_mpin: params[:set_mpin], confirm_mpin: params[:confirm_mpin], status_mpin: true)
              render json: { code: 200, message: "Successfully set pin" }
            else
              render json: { code: 422, message: "Pin and confirm pin do not match" }
            end
          else
            render json: { code: 400, message: "Pin and confirm pin are required" }
          end
        end

        def reset_transaction_pin
          # Validate params
          if params[:old_pin].blank? || params[:set_pin].blank? || params[:confirm_pin].blank?
            return render json: { code: 400, message: "Old pin, new pin, and confirm pin are required" }
          end

          user = current_user

          # Check if old pin matches
          unless user.set_pin == params[:old_pin]
            return render json: { code: 400, message: "Old pin does not match" }
          end

          # Check if new and confirm pin match
          unless params[:set_pin] == params[:confirm_pin]
            return render json: { code: 400, message: "New pin and confirm pin do not match" }
          end

          # Update the new pin
          if user.update(set_pin: params[:set_pin])
            render json: { code: 200, message: "Transaction pin updated successfully" }
          else
            render json: { code: 500, message: "Failed to update transaction pin" }
          end
        end


        def forget_transaction_pin
          # Check if email is provided
          if params[:email].blank?
            return render json: { code: 400, message: "Email is required" }
          end

          # Find user by email
          user = User.find_by(email: params[:email].strip)

          unless user
            return render json: { code: 404, message: "User not found with this email" }
          end

          # Generate a 6-digit OTP
          otp = rand(100000..999999).to_s

          # Save OTP and expiry time (10 minutes validity)
          user.update(email_otp: otp, email_otp_sent_at: Time.current + 10.minutes)

          # Send OTP via email (optional — only if you have UserMailer configured)
          begin
            UserMailer.transcation_email_otp(user: user, otp: otp).deliver_now
          rescue => e
            Rails.logger.error("Email sending failed: #{e.message}")
            return render json: { code: 500, message: "Failed to send OTP email" }
          end

          # Respond with success
          render json: { code: 200, message: "OTP sent successfully to your email" }
        end

        def verfiy_transaction_pin
          if params[:email].blank? || params[:otp].blank?
            return render json: { code: 400, message: "Email and OTP are required" }
          end

          user = User.find_by(email: params[:email].strip)
          return render json: { code: 404, message: "User not found" } unless user

          if user.email_otp != params[:otp]
            return render json: { code: 400, message: "Invalid OTP" }
          elsif user.email_otp_sent_at < Time.current
            return render json: { code: 400, message: "OTP has expired" }
          end

          render json: { code: 200, message: "OTP verified successfully" }
        end


      end
    end
  end
end
