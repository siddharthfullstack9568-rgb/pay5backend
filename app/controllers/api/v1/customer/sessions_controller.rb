class Api::V1::Customer::SessionsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'openssl'
  require 'cgi'
  before_action :set_or_create_user, only: [:login, :verify_otp]
  protect_from_forgery with: :null_session


  # def login_email
  #   @customer = User.find_or_create_by(email: params[:email], role_id: "5") do |u|
  #     u.first_name = params[:first_name] || "Guest User"
  #   end

  #   otp = rand(100000..999999).to_s
  #   @customer.update(email_otp: otp, email_otp_sent_at: Time.current)

  #   UserMailer.send_otp(@customer, otp).deliver_now.

  #     render json: { success: true, message: "OTP sent to email" }
  # end

  def login_email
    p "================ login_email"

    @customer = User.find_or_create_by(email: params[:email], role_id: "5") do |u|

      u.first_name = params[:first_name] || "Guest User"
    end

    otp = rand(100000..999999).to_s
    @customer.update(email_otp: otp, email_otp_sent_at: Time.current)

    UserMailer.send_otp(@customer, otp).deliver_now

    render json: { success: true, message: "OTP sent to email" }
  end


  def email_verify
    @customer = User.find_by(email: params[:email])

    p "==============customer======"
    p @customer.email_otp
    p "===============#{params[:email_otp]}"

    if @customer.email_otp == params[:email_otp]

      # OTP correct -> login success
      session_token = SecureRandom.hex(16)
      @customer.update(email_otp: nil, email_otp_sent_at: nil, session_token: session_token) # clear OTP

      # Send login success email

      render json: { success: true, message: "Login successful", user: @customer }
    else
      render json: { success: false, message: "Invalid or expired OTP" }, status: :unauthorized
    end
  end



  # curl "https://www.stpl.net.in/api/mt/SendSMS?user=amol@primepayindia.com&password=K7VSM1U7&senderid=TESTID&channel=Trans&DCS=0&flashsms=0&number=919876543210&text=Test&route=03"
  def login
    Rails.logger.info "====== LOGIN action triggered ======"

    # 1️⃣ Find user by phone_number
    @user = User.find_by(phone_number: params[:phone_number])
    unless @user
      return render json: { code: 404, message: "User not found with this phone number" }
    end

    # 2️⃣ Generate OTP (6 digits)
    otp = rand(100000..999999).to_s

    # 3️⃣ STPL credentials (stored in ENV or Rails credentials)
    stpl_user        =  "amol@primepayindia.com",
      stpl_pass        = "K7VSM1U7",
      stpl_sender      = "BHRTGW"  ,              # Approved sender ID
      stpl_template_id = 1107165678912345    ,  # DLT Template ID
    stpl_entity_id   = 1701165678901234567,   # DLT Entity ID (optional)

    # 4️⃣ Prepare SMS text
    sms_text = "Your OTP is #{otp}"

    # 5️⃣ Build API parameters as per STPL documentation
    params = {
      user:       stpl_user,
      password:   stpl_pass,
      senderid:   stpl_sender,
      channel:    "Trans",
      DCS:        "0",
      flashsms:   "0",
      number:     @user.phone_number,
      text:       sms_text,
      route:      "03",
      peid:       stpl_entity_id,
      templateid: stpl_template_id
    }

    # 6️⃣ Build request URI
    uri = URI("https://www.stpl.net.in/api/mt/SendSMS")
    uri.query = URI.encode_www_form(params)

    # 7️⃣ Send HTTP GET request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.read_timeout = 10

    # Allow disabling SSL verification only in development/test mode
    if Rails.env.development? || Rails.env.test? || ENV['STPL_SSL_VERIFY'] == "false"
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    else
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    # 8️⃣ Log STPL response (for debugging)
    Rails.logger.info "[STPL] Request URL: #{uri}"
    Rails.logger.info "[STPL] Response Code: #{response.code}"
    Rails.logger.info "[STPL] Response Body: #{response.body}"

    # 9️⃣ Handle response
    if response.is_a?(Net::HTTPSuccess) && response.body.present?
      @user.update(otp: otp, verify_otp: false)
      render json: {
        code: 200,
        message: "OTP sent successfully",
        otp: otp,  # ⚠️ Remove this in production
        stpl_response: response.body
      }
    else
      render json: {
        code: 500,
        message: "Failed to send OTP via STPL",
        error: response.body
      }, status: :internal_server_error
    end

  rescue => e
    Rails.logger.error "[STPL] Exception: #{e.class} - #{e.message}"
    render json: {
      code: 500,
      message: "Something went wrong while sending OTP",
      error: e.message
    }, status: :internal_server_error
  end



def verify_otp
  unless params[:otp].present?
    render json: { code: 422, message: "otp is required" }, status: :unprocessable_entity and return
  end
  p @user.otp
  p params[:otp]
  if @user && @user.otp.to_s == params[:otp].to_s
    @user.update(verify_otp: true, otp: nil)
    @user.regenerate_session_token
    render json: { code: 200, message: "OTP verified successfully", user: @user }
  else
    render json: { code: 401, message: "Invalid OTP" }, status: :unauthorized
  end

end

private

def set_or_create_user
  unless params[:phone_number].present?
    render json: { code: 422, message: "phone_number is required" }, status: :unprocessable_entity and return
  end

  @user = User.find_or_create_by(phone_number: params[:phone_number], role_id: 11)
end
end
