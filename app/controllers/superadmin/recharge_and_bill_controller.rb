class Superadmin::RechargeAndBillController < ApplicationController
  def index
  end

  def transaction
    @transcations = Transaction.all
  end

end
