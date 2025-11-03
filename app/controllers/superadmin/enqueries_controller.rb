class Superadmin::EnqueriesController < Superadmin::BaseController

  def index
    @enquires = Enquiry.all.order(created_at: :desc)
  end
end
