class Superadmin::AdminsController < ApplicationController

  def index
    @users = User.joins(:role).where(roles:{title: "admin"}).order(updated_at: :desc, created_at: :desc)
  end

  def new
  end

  def create
    assigner = User.find(136)
    @admin = User.new(user_params.merge(parent_id: assigner.id)) # assignee (new user)

    if @admin.save
      service_ids = params[:user][:service_ids] || [] # checkboxes se array milega

      service_ids.each do |sid|
        UserService.find_or_create_by!(
          assigner: assigner,
          assignee: @admin,
          service_id: sid
        )
      end

      redirect_to superadmin_admins_path, notice: "Admin created and services assigned successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @admin = User.find(params[:id])
  end

  def update
    @admin = User.find(params[:id])
    if @admin.update(user_params)

      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = User.find(136) # ya phir current_admin_user agar login se aa raha ho

      existing_ids = @admin.user_services.pluck(:service_id)

      # Unchecked services delete karo
      (existing_ids - service_ids).each do |sid|
        UserService.where(
          assigner: assigner,
          assignee: @admin,
          service_id: sid
        ).destroy_all
      end

      # Naye checked services add karo
      (service_ids - existing_ids).each do |sid|
        UserService.create!(
          assigner: assigner,
          assignee: @admin,
          service_id: sid
        )
      end

      redirect_to superadmin_admins_path, notice: "Admin updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
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
                                 :service_id,
                                 :parent_id,
                                 :address_proof_photo,
                                 :store_shop_photo,
                                 :passport_photo,
                                 :aadhaar_image,
                                 :pan_card_image,
                                 )
  end


end
