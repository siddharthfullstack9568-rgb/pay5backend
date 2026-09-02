class Api::V1::Agent::BeneficiariesController < Api::V1::Auth::BaseController
  
  def send_otp
    otp = rand(100000..999999).to_s

    result = Otp::SmsDealNowProvider.send_otp(
      params[:mobile],
      otp
    )

    render json: {
      success: result[:success],
      otp: otp,
      provider_response: result[:provider_response]
    }
  end

  def verify_otp
    result = Otp::SmsDealNowProvider.verify_otp(
      params[:mobile],
      params[:otp]
    )

    render json: result
  end
end