class Api::V1::Agent::HomeLoansController < Api::V1::Auth::BaseController

  def index
    loans = Houseloan.order(created_at: :desc)

    render json: {
      success: true,
      data: loans
    }, status: :ok
  end


  def create
    loan_params = housing_loan_params

    required = %i[
      mobile_number
      first_name
      last_name
      pan
      dob
      email
      pincode
      monthly_income
      housing_loan_amount
      property_type
      consumer_consent_ip
    ]

    missing = required.select { |field| loan_params[field].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing required fields: #{missing.join(', ')}"
      }, status: :unprocessable_entity
    end

    result = CreditLinks::HousingLoanService.new(loan_params).call

    Rails.logger.info "=========== RESULT ==========="
    Rails.logger.info result
  p "=============result[:data][:success]"
  p result[:data]["success"]
    # ✅ Correct success check
    if result[:data]["success"].present? && result[:data]["success"]   == "true"

      loan = Houseloan.find_or_create_by!(lead_id: result[:data][:leadId]) do |l|
        l.assign_attributes(
          loan_params.merge(
            user_id: current_user.id,
            consumer_consent_date: Time.current
          )
        )
      end

      render json: {
        success: true,
        message: result[:data][:message],
        data: loan,
        offers: result
      }, status: :ok

    else

      render json: {
        success: false,
        message: "Loan API failed",
        error: result
      }, status: :unprocessable_entity

    end

  rescue StandardError => e

    render json: {
      success: false,
      message: "Something went wrong",
      error: e.message
    }, status: :internal_server_error

  end


  private

  def housing_loan_params
    params.require(:home_loan).permit(
      :mobile_number,
      :first_name,
      :last_name,
      :pan,
      :dob,
      :email,
      :pincode,
      :monthly_income,
      :housing_loan_amount,
      :property_type,
      :consumer_consent_ip,
      :utm_id,
      :utm_campaign,
      :utm_source,
      :utm_medium
    )
  end

end