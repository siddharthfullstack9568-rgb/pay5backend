class Superadmin::ResetPasswordsController < Superadmin::BaseController
  before_action :require_superadmin_login

  def index
  end

  def reset_password
    @user = current_superadmin_user
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
        session[:superadmin_user_id] = nil
        redirect_to superadmin_sessions_login_path
      else
        flash[:alert] = "Failed to update password"
        render :reset_password
      end
    else
      flash[:alert] = "Old password does not match"
      render :reset_password
    end
  end

end
