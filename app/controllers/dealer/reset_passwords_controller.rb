class Dealer::ResetPasswordsController < Dealer::BaseController
  # before_action :require_superadmin_login
  layout "dealer"
  # before_action :authenticate_user!

  def index
  end

  def reset_page

  end

  def reset_password
    @user = current_dealer
    p "==================user"
    p @user
    p "===========old password #{params[:old_password]} and password #{params[:password].inspect}"

    if @user.authenticate(params[:old_password])
      new_pass = params[:password].is_a?(Array) ? params[:password].first : params[:password]
      p "===============new_pass: #{new_pass.inspect}"

      if @user.update(password: new_pass)
        flash[:notice] = "Password updated successfully!"
        session[:user_id] = nil
        redirect_to login_sessions_path
      else
        p "Update failed: #{@user.errors.full_messages}"
        flash[:alert] = "Failed to update password"
        render :reset_password
      end
    else
      flash[:alert] = "Old password does not match"
      p "=============Old password mismatch"
      render :reset_password
    end
  end


end
