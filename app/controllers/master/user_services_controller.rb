class Master::UserServicesController < Master::BaseController
  layout "master"
  # before_action :require_master_login
  # before_action :authenticate_user!

  before_action :set_user_service, only: [:edit, :update, :destroy, :update_status]

  def index
    @user_services = User.where(parent_id: current_master.id).order(created_at: :desc)
    # If you want only retailers for the current master, you can filter here later.
  end

  def new
    @services = UserService.where(assignee_id: 104).joins(:service).select("services.id, services.title")
    p "=-===========@services==="
    p @services
    @user_service = User.new
  end

  def create
    role_id = params[:user][:role_id]
    parent_id = params[:user][:parent_id]
    @user_service = User.new(user_params.merge(role_id: role_id, parent_id: current_master.id))

    if @user_service.save
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_master

      service_ids.each do |sid|
        UserService.find_or_create_by!(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        )
      end

      redirect_to master_user_services_path, notice: "Master created and services assigned successfully."
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
      assigner = current_master

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

      redirect_to master_user_services_path, notice: "Retailer updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end



  def update_status
    @enquiry = Enquiry.find_by(email: @user_service.email)
    @enquiry.update!(status: true) if @enquiry.present?

    @user_service.update!(status: !@user_service.status)

    # Send mail asynchronously using a thread
    if @user_service.status
      Thread.new do
        begin
          UserMailer.status_updated(@user_service).deliver_now
        rescue => e
          Rails.logger.error("Failed to send status update email: #{e.message}")
        ensure
          ActiveRecord::Base.connection_pool.release_connection
        end
      end
    end

    redirect_to master_user_services_path, notice: "Retailer status updated successfully."
  end

  def destroy
    @user_service.destroy
    redirect_to master_user_services_path, notice: "Retailer deleted successfully."
  end

  def set_pin
    p "===================set_pin"
  end

  def set_pin_update
    if params[:old_pin].present? && params[:set_pin].present? && params[:confirm_pin].present?
      # Step 1: Check if old PIN matches current_master's stored PIN
      if current_master.set_pin == params[:old_pin]
        # Step 2: Check if new and confirm PIN match
        if params[:set_pin] == params[:confirm_pin]
          if current_master.update(set_pin: params[:set_pin])
            flash[:notice] = "PIN updated successfully"
          else
            flash[:alert] = current_master.errors.full_messages.to_sentence
          end
        else
          flash[:alert] = "New PIN and Confirm PIN do not match"
        end
      else
        flash[:alert] = "Old PIN is incorrect"
      end
    else
      flash[:alert] = "All fields (Old PIN, New PIN, Confirm PIN) are required"
    end

    redirect_to master_user_services_set_pin_path
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
      :registration_certificate, :role_id, :company_name, :user_master_id, :confirm_password,
      :scheme_id, :domain_name, :cin_number, :service_id, :address_proof_photo,
      :store_shop_photo, :passport_photo, :aadhaar_image, :pan_card_image
    )
  end
end
