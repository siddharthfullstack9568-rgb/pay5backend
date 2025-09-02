class Superadmin::RetailersController < ApplicationController
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
  end

  def update
    if @retailer.update(retailer_params)
      redirect_to superadmin_retailers_path, notice: "Retailer updated successfully."
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
    # if @retailer.status
    #   UserMailer.status_updated(@retailer).deliver_later
    # end

    redirect_to superadmin_retailers_path, notice: "Retailer status updated successfully."
  end



  def destroy
    @retailer.destroy
    redirect_to superadmin_retailers_path, notice: "Retailer deleted successfully."
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
