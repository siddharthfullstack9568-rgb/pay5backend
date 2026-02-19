class Api::V1::Admin::PersonalLoansController < Api::V1::Auth::BaseController

 def list
  p "==================ss"
    admin = current_user

    # admin + all children users
    user_ids = admin.all_descendants.pluck(:id)
    user_ids << admin.id
    p "==========="
    personal_loans = PersonalLoan
                       .where(user_id: user_ids)
                       .order(created_at: :desc)
   p 
    render json: {
      code: 200,
      message: "Personal Loans List",
      personal_loans: personal_loans
    }
  end

  def update_loan_status
    personal_loan = PersonalLoan.find_by(id: params[:id])

    if personal_loan.blank?
      return render json: { code: 404, message: "Personal loan not found" }
    end

    personal_loan.update!(
      status: "rejected",
      pending_note: params[:pending_note]
    )

    render json: {
      code: 200,
      message: "Successfully updated personal loan status",
      personal_loan: personal_loan
    }
  rescue ActiveRecord::RecordInvalid => e
    render json: { code: 422, message: e.record.errors.full_messages.first }
  end


  def approved_loan_status
    personal_loan = PersonalLoan.find_by(id: params[:id])

    if personal_loan.blank?
      return render json: { code: 404, message: "Personal loan not found" }
    end

    personal_loan.update!(
      status: "approved",
    )

    render json: {
      code: 200,
      message: "Successfully approved your personal loan",
      personal_loan: personal_loan
    }
  rescue ActiveRecord::RecordInvalid => e
    render json: { code: 422, message: e.record.errors.full_messages.first }
  end


end