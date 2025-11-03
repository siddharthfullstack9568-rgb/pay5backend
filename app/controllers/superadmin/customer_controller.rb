class Superadmin::CustomerController < Superadmin::BaseController

  def index
    @curstomers = User.joins(:role).where(roles:{title: "customer"}).order(created_at: :desc)
  end

  def verify_status
    p "==============verify_statusverify_status="

    user = User.find_by(id: params[:id])
    p "==============user update="
    p user.kyc_verifications
    user.update(kyc_verifications: "approved")
  end

end
