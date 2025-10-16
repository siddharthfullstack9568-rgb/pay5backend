# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: "Bharatgrowbusiness@gmail.com"
  p "================UserMailer"

  def transcation_email_otp(user:, otp:)
    @user = user
    @otp = otp

    mail(
      to: @user.email,
      subject: "Your OTP for Transaction PIN Reset"
    )
  end

  def send_email_otp(user, otp)
    @user = user
    p "=================="
    p @user
    @otp = otp
    mail(to: @user.email, subject: "Your Login OTP Code")
  end

  def mpin_otp_email(user, otp)
    @user = user
    p "==========user"
    p @user.id
    @otp = otp
    mail(to: @user.email,subject: "Your MPIN Reset OTP")
  end

  def status_updated(user)
    p "=---------- user welcome"
    p user
    @user = user
    mail(to: @user.email, subject: "Your account status has been updated")
  end

  def send_otp(user, otp)
    Rails.logger.info "================UserMailer"
    @user = user
    @otp  = otp   # 👈 Instance variable बनाना जरूरी
    Rails.logger.info "====================user"
    Rails.logger.info @user.email
    Rails.logger.info "====================otp"
    Rails.logger.info @otp

    mail(to: @user.email, subject: "Your OTP Code", layout: false)
  end


end
