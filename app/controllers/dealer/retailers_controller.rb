class Dealer::RetailersController < Dealer::BaseController
  layout "dealer"
  #before_action :require_dealer_login
  # before_action :authenticate_user!

  before_action :set_retailer, only: [ :edit, :update, :destroy]

  def index
    p "============"
    p current_dealer
    @retailers = User.joins(:role).where(roles: { title: ["retailer"] } ,parent_id: current_dealer.id).order(created_at: :desc)
  end


  def new
    @retailer = User.new
  end

  def create
    @user_service = User.new(dealer_params.merge(role_id: 5, parent_id: current_dealer.id))

    if @user_service.save
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_dealer

      service_ids.each do |sid|
        UserService.find_or_create_by!(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        )
      end

      redirect_to dealer_retailers_path, notice: "Retailer created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @services = UserService.where(assignee_id: current_dealer.parent_id).joins(:service).select("services.id, services.title")
  end

  def update
    if @retailer.update(dealer_params)
      # Convert checked service IDs to integers
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_dealer
      @user_service = @retailer  # Define this properly

      # Fetch existing assigned service IDs
      existing_ids = UserService.where(
        assigner: assigner,
        assignee: @user_service
      ).pluck(:service_id)

      # Delete unselected services
      (existing_ids - service_ids).each do |sid|
        UserService.where(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        ).destroy_all
      end

      # Add newly selected services
      (service_ids - existing_ids).each do |sid|
        UserService.create!(
          assigner: assigner,
          assignee: @user_service,
          service_id: sid
        )
      end

      redirect_to dealer_retailers_path, notice: "Retailer updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def update_status
    @retailer = User.find(params[:id])
    @enquiry = Enquiry.find_by(email: @retailer.email)
    if @enquiry.present?
      @enquiry.update!(status: true)
    end
    @retailer.update!(status: !@retailer.status)

    # Send mail only if the account is active now
    if @retailer.status
      Thread.new do
        UserMailer.status_updated(@retailer).deliver_now
      end
    end

    redirect_to dealer_retailers_path, notice: "Retailer status updated successfully."
  end



  def destroy
    @retailer.destroy
    redirect_to dealer_retailers_path, notice: "Retailer deleted successfully."
  end

  private

  def set_retailer
    @retailer = User.find(params[:id])
  end

  def dealer_params
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
