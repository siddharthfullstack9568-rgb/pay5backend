class Superadmin::AdminsController < ApplicationController

  def index
    @users = User.joins(:role).where(roles:{title: "admin"}).order(updated_at: :desc, created_at: :desc)
  end

  def new
  end

  def create
    service_ids = params[:service_ids]
    p service_ids
    @admin = User.new(user_params)
    if @admin.save
      redirect_to superadmin_admins_path, notice: "Admin created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @admin = User.find(params[:id])
  end

  def update
    @admin = User.find(params[:id])
    @admin.update(user_params)
    redirect_to superadmin_admins_path, notice: "Admin created successfully."
  end

  def admin_update_stauts
    @admin = User.find(params[:id])
    p "============"
    p @admin
    @admin.update!(status: !@admin.status)

    # Send mail only if the account is active now
    # if @retailer.status
    #   UserMailer.status_updated(@retailer).deliver_later
    # end
    redirect_to superadmin_admins_path, notice: "Admin status updated successfully."
  end

  private

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
                                 :service_id)
  end


end
