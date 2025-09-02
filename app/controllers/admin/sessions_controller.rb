class Admin::SessionsController < ApplicationController
   layout false

  def login

  end

  def create
  user = User.find_by(email: params[:email])
  if user&.authenticate(params[:password]) && user.role.title == "admin"
    session[:admin_user_id] = user.id
    redirect_to admin_dashboards_index_path
  else
    flash[:alert] = "Please Enter Valid Email or Password"
    redirect_to admin_sessions_login_path
  end
end


  def destroy
    p "================="
    session[:admin_user_id] = nil
    redirect_to admin_sessions_login_path
  end


end
