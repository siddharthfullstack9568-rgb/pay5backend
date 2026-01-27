class Api::V1::Admin::SupportTicketsController < Api::V1::Auth::BaseController
  before_action :set_ticket, only: [:show, :update_status]

  def create
    full_name = params[:full_name]
    subject  = params[:subject]
    description = params[:description]
    email = params[:email]
    reference_id = params[:reference_id]

    if subject.blank? || description.blank? || email.blank? || reference_id.blank? || full_name.blank?
      return render json: { status: false, message: "subject, description & email & reference_id && full_name required" }, status: 400
    end

    ticket = SupportTicket.new(ticket_params.merge(user_id: current_user.id))
    ticket.status = "open"
    ticket.status_updated_at = Time.current

    if ticket.save
      render json: {
        success: true,
        message: "Ticket created successfully",
        data: ticket
      }, status: :created
    else
      render json: {
        success: false,
        errors: ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # =========================
  # GET /api/v1/support_tickets
  # List Tickets
  # =========================
  def index
    tickets = SupportTicket.order(created_at: :desc)

    tickets = tickets.where(status: params[:status]) if params[:status].present?
    tickets = tickets.where(service_type: params[:service_type]) if params[:service_type].present?
    tickets = tickets.where(user_id: params[:user_id]) if params[:user_id].present?

    render json: {
      success: true,
      count: tickets.count,
      data: tickets
    }
  end

  # =========================
  # GET /api/v1/support_tickets/:id
  # Show Ticket
  # =========================
  def show
    render json: {
      success: true,
      data: @ticket
    }
  end

  # =========================
  # PATCH /api/v1/support_tickets/:id/update_status
  # Update Status (Admin)
  # =========================
  def update_status
    status = params[:status]

    unless %w[open in_progress resolved].include?(status)
      return render json: {
        success: false,
        message: "Invalid status"
      }, status: :unprocessable_entity
    end

    @ticket.status = status
    @ticket.status_updated_at = Time.current

    if status == "resolved"
      @ticket.resolution_note = params[:resolution_note]
      @ticket.resolved_at = Time.current
    end

    if @ticket.save
      render json: {
        success: true,
        message: "Ticket status updated",
        data: @ticket
      }
    else
      render json: {
        success: false,
        errors: @ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def set_ticket
    @ticket = SupportTicket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      success: false,
      message: "Ticket not found"
    }, status: :not_found
  end

  def ticket_params
    params.require(:support_ticket).permit(
      :user_id,
      :full_name,
      :email,
      :service_type,
      :reference_id,
      :subject,
      :description,
      :attachment_url
    )
  end
end
