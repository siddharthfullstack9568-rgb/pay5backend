class Superadmin::Master::DashboardsController < ApplicationController
  def index
    @retailers = User.where(role: Role.find_by(title: "master")&.id).order(created_at: :desc)
  end
end
