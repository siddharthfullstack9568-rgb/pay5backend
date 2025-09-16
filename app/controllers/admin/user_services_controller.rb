class Admin::UserServicesController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login

  def index
    @users = User.where(parent_id: current_admin_user.id).order(created_at: :desc)
    # p "================="
    # p current_admin_user
    # # @users = User.joins(:role).where(roles: { title: ["retailer"] })
    # assignee_ids = UserService.where(assigner_id: current_admin_user.id).distinct.pluck(:assignee_id)
    # @users = User.where(id: assignee_ids).order(created_at: :desc)
    #  p @users
    # p "=============@usersss @usersss@usersss======"
    # p assignee_ids

  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    role_id = params[:user][:role_id]
    p "==========="
    p role_id
    @user = User.new(user_params.merge(role_id: role_id, parent_id: current_admin_user.id))

    if @user.save
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_admin_user

      service_ids.each do |sid|
        UserService.find_or_create_by!(
          assigner: assigner,
          assignee: @user,
          service_id: sid
        )
      end

      redirect_to admin_user_services_index_path, notice: "Admin created and services assigned successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_services_index_path, notice: "Retailer updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    @user = User.find(params[:id])
    @enquiry = Enquiry.find_by(email: @user.email)
    if @enquiry.present?
      @enquiry.update!(status: true)
    end
    @user.update!(status: !@user.status)

    # Send mail only if the account is active now
    # if @user.status
    #   UserMailer.status_updated(@user).deliver_later
    # end

    redirect_to admin_user_services_index_path, notice: "Retailer status updated successfully."
  end

  def view_blance
    # Wallet.where(user_id: )
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_services_index_path, notice: "Retailer deleted successfully."
  end

  def set_pin

  end

  def set_pin_update
    if params[:set_pin].present? && params[:confirm_pin].present?
      if params[:set_pin] == params[:confirm_pin]
        if current_admin_user.update(set_pin: params[:set_pin])
          flash[:notice] = "PIN set successfully"
        else
          flash[:alert] = current_admin_user.errors.full_messages.to_sentence
        end
      else
        flash[:alert] = "PIN and Confirm PIN do not match"
      end
    else
      flash[:alert] = "Both PIN fields are required"
    end

    redirect_to admin_user_services_set_pin_path
  end


  private

  def set_retailer
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :phone_number,
                                 :password,
                                 :otp,
                                 :verify_otp,
                                 :otp_expires_at,
                                 :country_code,
                                 :alternative_number,
                                 :aadhaar_number,
                                 :pan_card,
                                 :date_of_birth,
                                 :gender,
                                 :business_name,
                                 :business_owner_type,
                                 :business_nature_type,
                                 :business_registration_number,
                                 :gst_number,
                                 :pan_number,
                                 :address,
                                 :city,
                                 :state,
                                 :pincode,
                                 :landmark,
                                 :username,
                                 :scheme,
                                 :referred_by,
                                 :bank_name,
                                 :account_number,
                                 :ifsc_code,
                                 :account_holder_name,
                                 :notes,
                                 :session_token,
                                 :domin_name,
                                 :company_type,
                                 :registration_certificate,
                                 :role_id,
                                 :company_name,
                                 :user_admin_id,
                                 :confirm_password,
                                 :scheme_id,
                                 :domain_name,
                                 :cin_number,
                                 :service_id,
                                 :address_proof_photo,
                                 :store_shop_photo,
                                 :passport_photo,
                                 :aadhaar_image,
                                 :pan_card_image,
                                 :parent_id)
  end


end
