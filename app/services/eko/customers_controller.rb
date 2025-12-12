# app/controllers/dmt/customers_controller.rb
class Dmt::CustomersController < ApplicationController

  def check
    response = DmtCustomerService.check_profile(params[:customer_id])
    render json: response
  end

  def create
    payload = {
      initiator_id: 9962981729,
      user_code: 20810200,
      customer_id: params[:customer_id],
      name: params[:name],
      dob: params[:dob],
      residence_address: params[:address]
    }

    response = DmtCustomerService.create_customer(payload)
    render json: response
  end

  def verify_otp
    payload = {
      initiator_id: 9962981729,
      user_code: 20810200,
      customer_id: params[:customer_id],
      otp: params[:otp]
    }

    response = DmtCustomerService.verify_otp(payload)
    render json: response
  end
end
