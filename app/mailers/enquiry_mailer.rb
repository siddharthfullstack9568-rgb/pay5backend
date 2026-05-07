class EnquiryMailer < ApplicationMailer

    # -----------------------------------
    # SEND OTP MAIL
    # -----------------------------------
    def send_enquiry_otp(user, otp)
      @user = user
      @otp = otp
  
      mail(
        to: @user.email,
        subject: "Email Verification OTP"
      )
    end
  
    # -----------------------------------
    # SEND LOGIN CREDENTIALS
    # -----------------------------------
    def send_user_credentials(user, password)
      @user = user
      @password = password
  
      mail(
        to: @user.email,
        subject: "Your Login Credentials"
      )
    end
  end