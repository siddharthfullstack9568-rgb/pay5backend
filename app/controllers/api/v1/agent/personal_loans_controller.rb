class Api::V1::Agent::PersonalLoansController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def persoanl_loan_list
    persoanl_loans = PersonalLoan.where(user_id: current_user.id)
    render json: {code: 200, message: "Personal Loans List", persoanl_loans: persoanl_loans}
  end

  def check_eligibility
  loan_params = params.require(:personal_loan)

  required = %i[
    first_name email mobile dob pan_number
    monthly_income credit_score office_pin_code
  ]

  missing = required.select { |p| loan_params[p].blank? }

  if missing.any?
    return render json: {
      success: false,
      message: "Missing: #{missing.join(', ')}"
    }, status: :bad_request
  end

  # ✅ Age Validation
  begin
    dob_date = Date.parse(loan_params[:dob])

    if dob_date > Date.today
      return render json: {
        success: false,
        message: "DOB cannot be in future"
      }, status: :unprocessable_entity
    end

    age = calculate_age(dob_date)
  rescue
    return render json: {
      success: false,
      message: "Invalid DOB format"
    }, status: :unprocessable_entity
  end

  credit_score = loan_params[:credit_score].to_i

  unless credit_score.between?(300, 900)
    return render json: {
      success: false,
      message: "Credit score must be between 300 and 900"
    }, status: :unprocessable_entity
  end

  # 🔥 STRICT CIBIL CONDITION
  if credit_score < 650
    return render json: {
      success: false,
      message: "Loan rejected due to low CIBIL score",
      reasons: ["Low credit score"]
    }, status: :unprocessable_entity
  end

  # 🔥 Calculate other reasons
  reasons = []
  reasons << "Low income" if loan_params[:monthly_income].to_f < 15000
  reasons << "Age not between 22–55" unless age.between?(22, 55)

  # 🔥 Call external API
  service = CreditLinks::CreateLeadService.new(
    instant_params.merge(
      consumer_consent_ip: request.remote_ip
    )
  )

  result = service.call

  # 🔥 Save record (only if CIBIL >= 650)
  loan = PersonalLoan.find_or_initialize_by(mobile: loan_params[:mobile])
  loan.assign_attributes(instant_params)

  loan.lead_id = result.dig(:data, "leadId") if result[:success]

  loan.save!

  render json: {
    success: true,
    message: "Loan processed successfully",
    reasons: reasons,
    external_lead_created: result[:success],
    external_lead_id: loan.lead_id,
    external_response: result[:data] || result[:error]
  }, status: :ok
end




  def get_offer
  lead_id = params[:lead_id]

  if lead_id.blank?
    return render json: {
      success: false,
      message: "lead_id is required"
    }, status: :bad_request
  end

  service = CreditLinks::GetOffersService.new(lead_id)
  result = service.call

  if result[:success]

    offers_array = result.dig(:data, "offers") || []

    filtered_offers = offers_array.map do |offer|
      offer.to_h.except("kfs")
    end

    render json: {
      success: true,
      offers: filtered_offers
    }, status: :ok

  else
    render json: {
      success: false,
      error: result[:error]
    }, status: :unprocessable_entity
  end
end




  private

  def instant_params
    params.require(:personal_loan).permit(
      :first_name,
      :last_name,
      :email,
      :mobile,
      :dob,
      :pan_number,
      :monthly_income,
      :credit_score,
      :pincode,
      :employee_status,
      :employer_name,
      :office_pin_code
    )
  end

  def calculate_max_amount(loan)
    (loan.monthly_income.to_f * 20).to_i
  end

  def calculate_age(dob_date)
    age = Date.today.year - dob_date.year
    age -= 1 if Date.today < dob_date + age.years
    age
  end
end