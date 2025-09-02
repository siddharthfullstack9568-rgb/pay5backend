# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: "Bharatgrowbusiness"
  p "================UserMailer"
  def status_updated(user)
  	p "=---------- user welcome"
    p user
    @user = user
    mail(to: @user.email, subject: "Your account status has been updated")
  end
end
