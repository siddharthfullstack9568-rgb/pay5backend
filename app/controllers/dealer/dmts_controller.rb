class Dealer::DmtsController < Dealer::BaseController
  layout "dealer"

  def index
    @dmts = Dmt.where(parent_id: current_admin.id)

    if params[:sender_name].present?
      @dmts = @dmts.where("sender_name ILIKE ?", "%#{params[:sender_name]}%")
    end

    if params[:sender_mobile_number].present?
      @dmts = @dmts.where("sender_mobile_number LIKE ?", "%#{params[:sender_mobile_number]}%")
    end

    if params[:start_date].present?
      @dmts = @dmts.where("created_at >= ?", Date.parse(params[:start_date]).beginning_of_day)
    end

    if params[:end_date].present?
      @dmts = @dmts.where("created_at <= ?", Date.parse(params[:end_date]).end_of_day)
    end
  end


end
