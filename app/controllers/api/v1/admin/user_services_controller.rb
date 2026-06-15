class Api::V1::Admin::UserServicesController < Api::V1::Auth::BaseController
  before_action :set_user_service, only: [:edit ,:update, :update_status, :destroy]

  # -----------------------------------------
  # LIST RETAILERS/DEALERS CREATED BY ADMIN
  # -----------------------------------------
  def index
    users = current_user.all_descendants
    .sort_by(&:created_at)
    .reverse

    if users.any?
      render json: {
        code: 200,
        message: "Hierarchy users fetched successfully",
        users: users
      }
    else
      render json: {
        code: 404,
        message: "No hierarchy users found",
        users: []
      }
    end
  end


  def role_count
    user_ids = current_user.all_descendants.map(&:id)

    users = User.joins(:role).where(id: user_ids)

    counts = users.group('roles.title').count

    render json: {
      success: true,
      data: {
        master: counts['master'] || 0,
        dealer: counts['dealer'] || 0,
        retailer: counts['retailer'] || 0
      }
    }
  end




  def role_list
    roles = Role.all

    render json: {
      code: 200,
      message: "Role list fetched successfully",
      roles: roles.select(:id, :title)
    }
  end

  # def master_role
  #   users = User.joins(:role)
  #   .where(roles: { title: "master" }, parent_id: current_user.id, scheme_id: params[:scheme_id])

  #   if users.exists?
  #     render json: {
  #       code: 200,
  #       message: "Master users fetched successfully",
  #       users: users
  #     }
  #   else
  #     render json: {
  #       code: 404,
  #       message: "Master not found",
  #       users: []
  #     }
  #   end
  # end

  def master_role
    users = User.joins(:role)
    .where(roles: { title: "master" }, parent_id: current_user.id)

    if users.exists?
      render json: {
        code: 200,
        message: "Master users fetched successfully",
        users: users
      }
    else
      render json: {
        code: 404,
        message: "Master not found",
        users: []
      }
    end
  end


  def dealer_role
    users = User.joins(:role)
    .where(roles: { title: "dealer" }, parent_id: params[:master_id])

    if users.exists?
      render json: {
        code: 200,
        message: "Dealer users fetched successfully",
        users: users
      }
    else
      render json: {
        code: 404,
        message: "Dealer not found",
        users: []
      }
    end
  end

  def scheme_role
     p "--------------------"
    p current_user
    scheme_id = current_user.scheme_id
    scheme = Scheme.find_by(id: scheme_id)

    if scheme.present?
      render json: {
        code: 200,
        message: "Scheme found",
        scheme: scheme
      }
    else
      render json: {
        code: 404,
        message: "Scheme not found"
      }
    end
  end


  def role
    roles = Role.all
    render json: { code: 200, message: "Role List", roles: roles }
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
    p "--------------------"
    p current_user
    scheme_id = current_user.scheme_id
    scheme = Scheme.find_by(id: scheme_id)

    if scheme.present?
      render json: {
        code: 200,
        message: "Scheme found",
        scheme: scheme
      }
    else
      render json: {
        code: 404,
        message: "Scheme not found"
      }
    end
  end

   def scheme_role
    p "--------------------"
    p current_user
    scheme_id = current_user.scheme_id
    scheme = Scheme.find_by(id: scheme_id)

    if scheme.present?
      render json: {
        code: 200,
        message: "Scheme found",
        scheme: scheme
      }
    else
      render json: {
        code: 404,
        message: "Scheme not found"
      }
    end
  end


  def create
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

    email    = params[:email].to_s.strip.downcase
    username = params[:username].to_s.strip.downcase

    if User.where("LOWER(email) = ?", email).exists?
      return render json: {
        code: 409,
        message: "User already exists with this email"
      }, status: :conflict
    end

    if User.where("LOWER(username) = ?", username).exists?
      return render json: {
        code: 409,
        message: "User already exists with this username"
      }, status: :conflict
    end

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
    # 3️⃣ IMAGE UPLOADS
    # ------------------------

    aadhaar_url = params[:aadhaar_image].present? ?
      Cloudinary::Uploader.upload(params[:aadhaar_image], folder: "users/aadhaar")["secure_url"] : nil

    pan_url = params[:pan_card_image].present? ?
      Cloudinary::Uploader.upload(params[:pan_card_image], folder: "users/pan")["secure_url"] : nil

    shop_url = params[:store_shop_photo].present? ?
      Cloudinary::Uploader.upload(params[:store_shop_photo], folder: "users/store")["secure_url"] : nil

    # ------------------------
    # 4️⃣ TRANSACTION
    # ------------------------
    ActiveRecord::Base.transaction do

      if %w[master dealer retailer].include?(params[:title].to_s.downcase)
        user = User.new(
          user_params.merge(
            role_id: params[:role_id],
            parent_id: current_user.id,
            aadhaar_image: aadhaar_url,
            pan_card_image: pan_url,
            store_shop_photo: shop_url
          )
        )
      else
        master_fetch = User.find_by(id: params[:master_id])
        return render json: {
          code: 404,
          message: "Master not found"
        } unless master_fetch

        dealer_fetch = User.find_by(id: params[:dealer_id])
        return render json: {
          code: 404,
          message: "Dealer not found"
        } unless dealer_fetch

        user = User.new(
          user_params.merge(
            role_id: params[:role_id],
            parent_id: dealer_fetch.id,
            aadhaar_image: aadhaar_url,
            pan_card_image: pan_url,
            store_shop_photo: shop_url
          )
        )
      end

      unless user.save
        return render json: {
          code: 422,
          message: user.errors.full_messages.to_sentence
        }
      end

      # ---- User Services ----
      service_ids.each do |sid|
        UserService.create!(
          assigner: current_user,
          assignee: user,
          service_id: sid
        )
      end

      # residence_address JSON (reuse at both places)
      # ===============================
      # ONLY FOR RETAILER ROLE
      # ===============================
      # if user.role&.title == "retailer"

      #   # -------------------------------
      #   # EKO USER ONBOARD
      #   # -------------------------------
      #   response = EkoDmt::UserOnboardService.new(
      #     initiator_id: "9212094999",
      #     pan_number:   user.pan_card,
      #     mobile:       user.phone_number,
      #     first_name:   user.first_name,
      #     last_name:    user.last_name,
      #     email:        user.email,
      #     dob:          user.date_of_birth,
      #     shop_name:    user.business_name,
      #     residence_address: params[:residence_address]
      #   ).call

      #   p "==========response============="
      #   p response

      #   user_code = response.dig("data", "user_code") || response["user_code"]
      #   p "================="
      #   p user_code
      #   if user_code.blank?
      #     render json: {
      #       code: 422,
      #       message: response["message"] || "User code not received from EKO",
      #       raw: response
      #     }, status: :unprocessable_entity
      #     raise ActiveRecord::Rollback
      #   end

      #   user.update!(
      #     user_code: user_code,
      #     eko_onboard_first_step: true
      #   )

      #   # -------------------------------
      #   # EKO DMT CUSTOMER CREATE
      #   # -------------------------------
      #   resp = EkoDmt::DmtCustomerCreateService.new(
      #     customer_id:       user.phone_number,
      #     initiator_id:      "9212094999",
      #     user_code:         user.user_code,
      #     name:              user.first_name,
      #     dob:               user.date_of_birth,
      #     residence_address: params[:residence_address]
      #   ).call

      #   p "===========resp========"
      #   p resp
      #   user.update!(
      #     eko_onboard_first_step: true
      #   )

      #   p "============respresp============="
      #   p resp

      # end

      # residence_address JSON (reuse at both places)
      # ===============================
      # ONLY FOR RETAILER ROLE
      # ===============================


      return render json: {
        code: 201,
        message: "User created successfully",
        user: user
      }
    end

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

    ActiveRecord::Base.transaction do
      # ==============================
      # 1️⃣ IMAGE UPLOAD (OPTIONAL)
      # ==============================
      image_params = {}

      if params[:aadhaar_image].present?
        image_params[:aadhaar_image] =
        Cloudinary::Uploader.upload(
          params[:aadhaar_image],
          folder: "users/aadhaar"
        )["secure_url"]
      end

      if params[:pan_card_image].present?
        image_params[:pan_card_image] =
        Cloudinary::Uploader.upload(
          params[:pan_card_image],
          folder: "users/pan"
        )["secure_url"]
      end

      if params[:store_shop_photo].present?
        image_params[:store_shop_photo] =
        Cloudinary::Uploader.upload(
          params[:store_shop_photo],
          folder: "users/store"
        )["secure_url"]
      end

      # ==============================
      # 2️⃣ UPDATE USER BASIC DETAILS
      # ==============================
      unless @user_service.update(user_params.merge(image_params))
        raise ActiveRecord::Rollback,
          @user_service.errors.full_messages.join(", ")
      end

      # ==============================
      # 3️⃣ UPDATE SERVICES MAPPING
      # ==============================
      existing_ids = @user_service.user_services.pluck(:service_id)

      # Remove unselected services
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

      # ==============================
      # 4️⃣ BANK CREATE / UPDATE
      # ==============================
      if params[:bank_name].present? ||
          params[:account_number].present? ||
          params[:ifsc_code].present?

        bank = Bank.find_or_initialize_by(user: @user_service)

        bank.update!(
          bank_name: params[:bank_name],
          account_number: params[:account_number],
          ifsc_code: params[:ifsc_code]
        )
      end
    end

    # ==============================
    # 5️⃣ SUCCESS RESPONSE
    # ==============================
    render json: {
      code: 200,
      message: "User updated successfully",
      user: @user_service,
      updated_service_ids: service_ids
    }

  rescue StandardError => e
    render json: {
      code: 422,
      message: "Update failed",
      error: e.message
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

  def upload_image(file, folder)
    return nil unless file.present?

    result = Cloudinary::Uploader.upload(
      file,
      folder: folder,
      resource_type: :image
    )

    result["secure_url"]
  end

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
      :store_shop_photo, :passport_photo, :aadhaar_image, :pan_card_image, :permanent_address, :permanent_landmark,
      :permanent_landmark, :permanent_postal_code, :permanent_address, :permanent_city, :permanent_state, :permanent_pincode
    )
  end
end
