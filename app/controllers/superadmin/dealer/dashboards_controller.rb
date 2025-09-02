class Admin::Superadmin::DashboardsController < ApplicationController
  def index
    @retailers = User.where(role: Role.find_by(title: "dealer")&.id).order(created_at: :desc)
  end
end
