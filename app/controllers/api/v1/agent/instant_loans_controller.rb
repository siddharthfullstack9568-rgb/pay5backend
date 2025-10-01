class Api::V1::Agent::InstantLoansController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def check_eligibility
    required = %i[first_name email mobile dob pan_number]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    loan = InstantLoan.new(instant_params)
    loan.save
    if loan.monthly_income.present? && loan.credit_score.present?
      if loan.monthly_income.to_f >= 20000 && loan.credit_score.to_i >= 650
        render json: {
          success: true,
          message: "User is eligible for loan",
          eligibility: {
            max_amount: calculate_max_amount(loan),
            interest_rate: "12.5%",
            tenure_options: [6, 12, 24]
          }
        }, status: :ok
      else
        render json: {
          success: false,
          message: "User is not eligible for loan",
          reason: "Low income or credit score"
        }, status: :unprocessable_entity
      end
    else
      render json: {
        success: false,
        message: "Missing required parameters"
      }, status: :bad_request
    end
  end

  private

  def instant_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :employee_status,
      :dob,
      :pan_number,
      :aadhaar_number,
      :monthly_income,
      :credit_score,
      :fetch_credit_score,
      :mobile
    )
  end

  def calculate_max_amount(loan)
    if loan.credit_score.to_i > 750
      loan.monthly_income.to_f * 10
    else
      loan.monthly_income.to_f * 5
    end
  end
end
