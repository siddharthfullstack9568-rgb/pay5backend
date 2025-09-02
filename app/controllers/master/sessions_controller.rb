class Master::SessionsController < Master::BaseController
  layout false

  def login

  end

  def create
    p "====================== userssssssssss"
    p params[:email]
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password]) && user.role.title == "master"
      session[:master_user_id] = user.id
      redirect_to master_dashboards_index_path
    else
      flash[:alert] = "Please Enter Valid Email or Password"
      redirect_to master_sessions_login_path
    end
  end

  def destroy
    p "================="
    session[:master_user_id] = nil
    redirect_to master_sessions_login_path
  end


end
