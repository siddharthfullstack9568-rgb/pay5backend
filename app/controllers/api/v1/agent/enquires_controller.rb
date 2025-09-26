class Api::V1::Agent::EnquiresController < Api::V1::Agent::BaseController
  skip_before_action :verify_authenticity_token

  def create
    enquiry = Enquiry.new(enquiry_params)
    case params[:id_proof]
    when "Aadhaar"
      enquiry.aadhaar_number = params[:id_number]
    when "Pancard"
      enquiry.pan_card = params[:id_number]
    end
    if enquiry.save
      render json: {
        code: 201,
        message: "Enquiry created successfully",
        enquiry: enquiry
      }, status: :created
    else
      render json: {
        code: 422,
        message: "Failed to create enquiry",
        errors: enquiry.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def enquiry_params
    params.permit(
      :first_name, :last_name, :email, :phone_number, 
      :aadhaar_number, :pan_card, :role_id
    )
  end
end
