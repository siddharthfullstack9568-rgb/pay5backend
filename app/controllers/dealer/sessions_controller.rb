class Dealer::SessionsController < Master::BaseController
  layout false

  def login

  end

  def create
    p "====================== userssssssssss"
    p "====================== userssssssssss"

    p params[:email]
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password]) && user.role.title == "dealer"
      session[:dealer_user_id] = user.id
      redirect_to dealer_dashboards_index_path
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def forgot_page
    
  end

  def destroy
    p "================="
    session[:dealer_user_id] = nil
    redirect_to dealer_sessions_login_path
  end


end
