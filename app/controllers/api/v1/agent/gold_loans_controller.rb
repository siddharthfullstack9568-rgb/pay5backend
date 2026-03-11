class Api::V1::Agent::GoldLoansController < Api::V1::Auth::BaseController

  before_action :set_gold_loan, only: [:show, :update, :destroy]

  # 🔹 GET /api_gold_loans
  def index
  loans = GoldLoan.order(created_at: :desc)

  render json: {
    success: true,
    data: loans
  }, status: :ok
end


def show
  render json: {
    success: true,
    data: @gold_loan
  }, status: :ok
end


def create
  loan = GoldLoan.new(gold_loan_params)

  required = %i[
    mobile_number
    first_name
    last_name
    pan
    email
    pincode
    loan_amount
    consumer_consent_ip
  ]

  missing = required.select { |field| gold_loan_params[field].blank? }

  if missing.any?
    return render json: {
      success: false,
      message: "Missing required fields: #{missing.join(', ')}"
    }, status: :unprocessable_entity
  end

  unless loan.mobile_number.match?(/^\d{10}$/)
    return render json: {
      success: false,
      message: "Mobile number must be 10 digits"
    }, status: :unprocessable_entity
  end

  unless loan.pan.match?(/^[A-Z]{5}[0-9]{4}[A-Z]{1}$/)
    return render json: {
      success: false,
      message: "Invalid PAN format"
    }, status: :unprocessable_entity
  end

  loan.user_id = current_user.id

  if loan.save
    result = CreditLinks::GoldLoanService.new(loan).call

    Rails.logger.info "========= CreditLinks Response ========="
    Rails.logger.info result

    if result[:data].present? && result[:data]["success"] == "true"

      # save lead_id from CreditLinks
      loan.update(lead_id: result[:data]["leadId"])

      render json: {
        success: true,
        message: result[:data]["message"],
        data: loan,
        offers: result[:data]["offers"]
      }, status: :created

    else

      render json: {
        success: false,
        message: "CreditLinks API failed",
        credit_links_response: result[:data]
      }, status: :unprocessable_entity

    end
  else
    render json: {
      success: false,
      errors: loan.errors.full_messages
    }, status: :unprocessable_entity
  end
end

  # 🔹 PATCH/PUT /api_gold_loans/:id
  def update
    if @gold_loan.update(gold_loan_params)
      render json: {
        success: true,
        message: "Gold loan updated successfully",
        data: @gold_loan
      }, status: :ok
    else
      render json: {
        success: false,
        errors: @gold_loan.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # 🔹 DELETE /api_gold_loans/:id
  def destroy
    @gold_loan.destroy

    render json: {
      success: true,
      message: "Gold loan deleted successfully"
    }, status: :ok
  end

  private

  def set_gold_loan
    @gold_loan = GoldLoan.find_by(id: params[:id])

    unless @gold_loan
      render json: {
        success: false,
        message: "Gold loan not found"
      }, status: :not_found
    end
  end

  def gold_loan_params
    params.permit(
      :mobile_number,
      :first_name,
      :last_name,
      :pan,
      :email,
      :pincode,
      :loan_amount,
      :consumer_consent_date,
      :consumer_consent_ip,
      :utm_id,
      :utm_campaign,
      :utm_source,
      :utm_medium,
      :utm_content,
      :utm_term,
      :pid,
      :sub_id1,
      :sub_id2,
      :sub_id3,
      :lead_id,
      :user_id
    )
  end
end