class Admin::ResetPasswordsController < Admin::BaseController
  # before_action :require_superadmin_login
  layout "admin"
 # before_action :authenticate_user!
# before_action :authenticate_user!

  def index
  end

  def reset_page
    p "===========admin"
  end

  def reset_password
    @user = current_admin
    p "==================user"
    p @user
    p "===========old password #{params[:old_password]} and password #{[params[:password].to_s]}"
    # params[:old_password] aur params[:new_password] frontend se aayenge
    if @user.authenticate(params[:old_password])
      new_pass = params[:password].is_a?(Array) ? params[:password].first : params[:password]
      p "===============new_pass"
      p new_pass
      if @user.update(password: new_pass)
        flash[:notice] = "Password updated successfully!"
        session[:user_id] = nil
        redirect_to login_sessions_path
      else
        flash[:alert] = "Failed to update password"
        redirect_to admin_reset_passwords_reset_page_path
      end
    else
      flash[:alert] = "Old password does not match"
      redirect_to admin_reset_passwords_reset_page_path
    end
  end

end
