class Superadmin::FinancialServicesController < Superadmin::BaseController

  def index
    @transactions = Transaction.where(service_product: [15, 17, 18])
    .order(created_at: :desc)
    .limit(50)

    puts "============"
    puts @transactions.inspect

    if params[:type].present? && params[:type] != "all"
      @transactions = @transactions
      .eager_load(:service_product)
      .where(service_products: { company_name: params[:type] })
    end
  end


end
