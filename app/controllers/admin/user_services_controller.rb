class Admin::UserServicesController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login
  before_action :set_user_service, only: [:edit, :update, :destroy, :update_status]

  def index
    @user_services = User.where(parent_id: current_admin_user.id).order(created_at: :desc)
    # If you want only retailers for the current admin, you can filter here later.
  end


  def new
    @services = UserService.where(assignee_id: 104).joins(:service).select("services.id, services.title")
    p "=-===========@services==="
    p @services
    @user_service = User.new
  end

  def create
    role_id = params[:user][:role_id]
    @user_service = User.new(user_params.merge(role_id: role_id, parent_id: current_admin_user.id))

    if @user_service.save
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_admin_user

      service_ids.each do |sid|
        UserService.find_or_create_by!(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        )
      end

      redirect_to admin_user_services_path, notice: "Admin created and services assigned successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @services = UserService.where(assignee_id: 104).joins(:service).select("services.id, services.title")
  end

  def update
    if @user_service.update(user_params)
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_admin_user

      # 1️⃣ Purane records nikaalo (jo already assigned hai)
      existing_ids = @user_service.user_services.pluck(:service_id)

      # 2️⃣ Delete karo jo ab uncheck ho gaye hain
      (existing_ids - service_ids).each do |sid|
        UserService.where(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        ).destroy_all
      end

      # 3️⃣ Add karo jo naye checked hain
      (service_ids - existing_ids).each do |sid|
        UserService.create!(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        )
      end

      redirect_to admin_user_services_path, notice: "Retailer updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end



  def update_status
    @enquiry = Enquiry.find_by(email: @user_service.email)
    if @enquiry.present?
      @enquiry.update!(status: true)
    end
    @user_service.update!(status: !@user_service.status)

    redirect_to admin_user_services_path, notice: "Retailer status updated successfully."
  end

  def destroy
    @user_service.destroy
    redirect_to admin_user_services_path, notice: "Retailer deleted successfully."
  end

  private

  def set_user_service
    @user_service = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :phone_number, :password, :otp, :verify_otp,
      :otp_expires_at, :country_code, :alternative_number, :aadhaar_number, :pan_card,
      :date_of_birth, :gender, :business_name, :business_owner_type, :business_nature_type,
      :business_registration_number, :gst_number, :pan_number, :address, :city, :state,
      :pincode, :landmark, :username, :scheme, :referred_by, :bank_name, :account_number,
      :ifsc_code, :account_holder_name, :notes, :session_token, :domin_name, :company_type,
      :registration_certificate, :role_id, :company_name, :user_admin_id, :confirm_password,
      :scheme_id, :domain_name, :cin_number, :service_id, :address_proof_photo,
      :store_shop_photo, :passport_photo, :aadhaar_image, :pan_card_image
    )
  end
end
