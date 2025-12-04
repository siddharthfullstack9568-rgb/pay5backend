class Api::V1::Admin::UserServicesController < Api::V1::Auth::BaseController
  before_action :set_user_service, only: [:edit ,:update, :update_status, :destroy]

  # -----------------------------------------
  # LIST RETAILERS/DEALERS CREATED BY ADMIN
  # -----------------------------------------
  def index
    p "===================="
    p current_user
    users = User.where(parent_id: current_user.id).order(created_at: :desc)

    render json: { code: 200, message: "Users fetched", users: users }
  end

  def role_list
    roles = Role.all

    render json: {
      code: 200,
      message: "Role list fetched successfully",
      roles: roles.select(:id, :title)
    }
  end

  def service_list
    services = current_user.user_services
    .joins(:service)
    .select("services.id, services.title")

    render json: {
      code: 200,
      message: "Service list fetched successfully",
      assigned_services: services.map { |s| { id: s.id, title: s.title } }
    }
  end

  def scheme_list
    schemes = current_user.schemes.select(:id, :scheme_name, :scheme_type, :commision_rate)

    render json: {
      code: 200,
      message: "Scheme list fetched successfully",
      schemes: schemes.map { |s|
        {
          id: s.id,
          scheme_name: s.scheme_name,
          scheme_type: s.scheme_type,
          commision_rate: s.commision_rate
        }
      }
    }
  end


  def create
    # ------------------------
    # 1️⃣ REQUIRED FIELD CHECK
    # ------------------------
    required_fields = [
      :first_name, :last_name, :email, :phone_number, :password,
      :role_id, :service_ids, :scheme_id
    ]

    missing = required_fields.select { |f| params[f].blank? }

    if missing.any?
      return render json: {
        code: 400,
        message: "Missing required fields",
        missing_fields: missing
      }
    end

    # ------------------------
    # Email already exists?
    # ------------------------
    if User.exists?(email: params[:email].strip.downcase)
      return render json: {
        code: 409,
        message: "User already exists with this email"
      }, status: :conflict
    end

    # ------------------------
    # 2️⃣ EXTRA VALIDATIONS
    # ------------------------

    unless params[:email].match?(/\A[^@\s]+@[^@\s]+\z/)
      return render json: { code: 422, message: "Invalid email format" }
    end

    unless params[:phone_number].to_s.match?(/\A[0-9]{10}\z/)
      return render json: { code: 422, message: "Invalid phone number (10 digits required)" }
    end

    if params[:aadhaar_number].present? &&
        !params[:aadhaar_number].to_s.match?(/\A[0-9]{12}\z/)
      return render json: { code: 422, message: "Aadhaar must be 12 digits" }
    end

    if params[:pan_card].present? &&
        !params[:pan_card].to_s.match?(/\A[A-Z]{5}[0-9]{4}[A-Z]{1}\z/)
      return render json: { code: 422, message: "PAN number is invalid" }
    end

    service_ids = Array(params[:service_ids]).map(&:to_i)
    if service_ids.empty?
      return render json: { code: 422, message: "At least one service must be selected" }
    end

    # ------------------------
    # 3️⃣ TRANSACTION START
    # ------------------------
    ActiveRecord::Base.transaction do
      user = User.new(
        user_params.merge(
          role_id: params[:role_id],
          parent_id: current_user.id
        )
      )

      # 3.1 User Save
      unless user.save
        raise ActiveRecord::Rollback
      end

      # 3.2 Assign Services
      service_ids.each do |sid|
        service = UserService.new(
          assigner: current_user,
          assignee: user,
          service_id: sid
        )

        unless service.save
          raise ActiveRecord::Rollback
        end
      end

      # Success response
      return render json: {
        code: 201,
        message: "User created successfully and services assigned",
        user: user
      }
    end

    # If rollback happens
    render json: {
      code: 422,
      message: "User creation failed due to service assignment error"
    }
  end


  def edit
    # 1️⃣ User details
    user = @user_service
    user_services = UserService.where(assignee_id: current_user.id).joins(:service).select("services.id, services.title")

    assigned_services = user.user_services
    .joins(:service)
    .pluck("services.id", "services.title")

    render json: {
      code: 200,
      message: "User data fetched successfully",
      user: user,
      user_services: user_services,
      assigned_services: assigned_services,
    }
  end


  # -----------------------------------------
  # UPDATE USER + SERVICES
  # -----------------------------------------
  def update
    service_ids = Array(params[:service_ids]).map(&:to_i)

    # 1️⃣ Update User Basic Details
    unless @user_service.update(user_params)
      return render json: {
        code: 422,
        message: "Update failed",
        errors: @user_service.errors.full_messages
      }
    end

    # 2️⃣ Update Services Mapping
    existing_ids = @user_service.user_services.pluck(:service_id)

    # Remove unselected
    (existing_ids - service_ids).each do |sid|
      UserService.where(
        assigner: current_user,
        assignee: @user_service,
        service_id: sid
      ).destroy_all
    end

    # Add new services
    (service_ids - existing_ids).each do |sid|
      UserService.create!(
        assigner: current_user,
        assignee: @user_service,
        service_id: sid
      )
    end

    # 3️⃣ Response
    render json: {
      code: 200,
      message: "User updated successfully",
      user: @user_service,
      updated_service_ids: service_ids
    }
  end


  # -----------------------------------------
  # UPDATE USER ACTIVE/INACTIVE STATUS
  # -----------------------------------------
  def update_status
    enquiry = Enquiry.find_by(email: @user_service.email)
    enquiry.update(status: true) if enquiry.present?

    # toggle status
    @user_service.update(status: !@user_service.status)

    # send email ONLY when status is true
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

    # ALWAYS send success response
    render json: { code: 200, message: "User status updated", user: @user_service }
  end


  # -----------------------------------------
  # DELETE USER
  # -----------------------------------------
  def destroy
    @user_service.destroy

    render json: { code: 200, message: "User deleted successfully" }
  end

  # -----------------------------------------
  # SET PIN
  # -----------------------------------------
  def set_pin_update
    unless params[:old_pin].present? && params[:set_pin].present? && params[:confirm_pin].present?
      return render json: { code: 400, message: "All fields are required" }
    end

    # Old PIN check
    unless current_user.set_pin == params[:old_pin]
      return render json: { code: 401, message: "Old PIN incorrect" }
    end

    # New PIN match
    unless params[:set_pin] == params[:confirm_pin]
      return render json: { code: 401, message: "New PIN and Confirm PIN must match" }
    end

    if current_user.update(set_pin: params[:set_pin])
      render json: { code: 200, message: "PIN updated successfully" }
    else
      render json: { code: 422, message: current_user.errors.full_messages.to_sentence }
    end
  end

  private

  def set_user_service
    @user_service = User.find(params[:id])
  end

  def user_params
    params.permit(
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
