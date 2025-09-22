class Superadmin::CustomerController < ApplicationController

  def index
    @curstomers = User.joins(:role).where(roles:{title: "customer"})
  end
end
