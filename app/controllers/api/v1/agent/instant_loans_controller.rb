class Api::V1::Agent::InstantLoansController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def instant_loan_list
    persoanl_loans = InstantLoan.all
    render json: {code: 200, message: "Personal Loans List", persoanl_loans: persoanl_loans}
  end

  def check_eligibility
    required = %i[first_name email mobile dob pan_number monthly_income credit_score]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    loan = InstantLoan.new(instant_params)

    # Convert dob to age
    begin
      dob_date = Date.parse(loan.dob.to_s)
      age = ((Date.today - dob_date) / 365).to_i
    rescue
      return render json: { success: false, message: "Invalid date of birth format" }, status: :unprocessable_entity
    end

    # Check income, credit score, and age range
    if loan.monthly_income.to_f >= 15000 && loan.credit_score.to_i >= 650 && age.between?(22, 55)
      loan.save

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
      reason = []
      reason << "Low income" if loan.monthly_income.to_f < 15000
      reason << "Low credit score" if loan.credit_score.to_i < 650
      reason << "Age not between 22–55" unless age.between?(22, 55)

      render json: {
        success: false,
        message: "User is not eligible for loan",
        reason: reason.join(", ")
      }, status: :unprocessable_entity
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
