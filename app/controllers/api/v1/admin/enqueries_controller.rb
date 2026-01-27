class Api::V1::Admin::EnqueriesController < Api::V1::Auth::BaseController

  def index
    enquiries = Enquiry.includes(:role)

    render json: {
      code: 200,
      message: "Enquiry list show",
      enquiries: enquiries.map do |enquiry|
        enquiry.as_json(except: [:role_id]).merge(
          role: enquiry.role&.title&.capitalize
        )
      end
    }
  end


end
