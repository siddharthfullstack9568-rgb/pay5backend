class Api::V1::Customer::LocationsController < Api::V1::Customer::BaseController


 def index
 	p current_user.kyc_verifications
 	render json: { code: 200, message: "locations get" }
 end

end