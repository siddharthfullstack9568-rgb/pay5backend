class Superadmin::RetailersController < Superadmin::BaseController
  before_action :set_retailer, only: [:show, :edit, :update, :destroy]

  def index
    @retailers = User.joins(:role).where(roles: { title: ["retailer", "master", "dealer"] }).order(created_at: :desc)
  end

  def show
  end

  def new
    @retailer = User.new
  end

  def create
    role_id = params[:user][:role_id]
    p "==========="
    p role_id
    @retailer = User.new(retailer_params.merge(role_id: role_id))

    if @retailer.save
      redirect_to superadmin_retailers_path, notice: "Retailer created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
     @services = UserService.where(assignee_id: 104).joins(:service).select("services.id, services.title")
    p @services
  end

  def update
     if @retailer.update(retailer_params)
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = current_admin

      # 1️⃣ Purane records nikaalo (jo already assigned hai)
      existing_ids = @retailer.user_services.pluck(:service_id)

      # 2️⃣ Delete karo jo ab uncheck ho gaye hain
      (existing_ids - service_ids).each do |sid|
        UserService.where(
          assigner: assigner,
          assignee: @retailer,
          service_id: sid
        ).destroy_all
      end

      # 3️⃣ Add karo jo naye checked hain
      (service_ids - existing_ids).each do |sid|
        UserService.create!(
          assigner: assigner,
          assignee: @retailer,
          service_id: sid
        )
      end

      redirect_to admin_user_services_path, notice: "Retailer updated successfully."
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
      UserMailer.status_updated(@retailer).deliver_now
    end

    redirect_to superadmin_retailers_path, notice: "Retailer status updated successfully."
  end



  def destroy
    @retailer.destroy
    redirect_to superadmin_retailers_path, notice: "Retailer deleted successfully."
  end

  def export
    @retailers = User.all

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"retailers-#{Date.today}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  private

  def set_retailer
    @retailer = User.find(params[:id])
  end

  def retailer_params
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
                                 :session_token,)
  end
end
