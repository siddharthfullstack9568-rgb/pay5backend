class Api::V1::Agent::SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def login
    enquiry = Enquiry.find_by(email: params[:email].to_s.strip)
    user = User.find_by(email: params[:email].to_s.strip)

    if enquiry.present?
      if !enquiry.status
        return render json: { code: 200, message: "Please wait, admin will verify you" }, status: :ok
      end
    end

    unless user
      return render json: { code: 401, message: "Invalid email or password" }, status: :unauthorized
    end

    if !user.status
      return render json: { code: 200, message: "Please wait, admin will verify you" }, status: :ok
    end

    if user.authenticate(params[:password])
      token = SecureRandom.hex(20)
      user.update(session_token: token)

      render json: { 
        code: 200, 
        message: "Login successful", 
        user: user 
      }, status: :ok
    else
      render json: { 
        code: 401, 
        message: "Invalid email or password" 
      }, status: :unauthorized
    end
  end

   def create
    user = User.new(retailer_params.merge(status: false))
    
    case params[:id_proof]
    when "Aadhaar"
      user.aadhaar_number = params[:id_number]
    when "Pancard"
      user.pan_card = params[:id_number]
    end

    if user.save
      render json: {
        code: 201,
        message: "User created successfully",
        user: user
      }, status: :created
    else
      render json: {
        code: 422,
        message: "User creation failed",
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end



  def role
    roles = Role.all
    render json: { code: 200, message: "role list", roles: roles}
  end


  private

  def retailer_params
    params.permit(:first_name, 
      :last_name, 
      :email, 
      :phone_number, 
      :password, 
      :otp, 
      :role_id,
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
