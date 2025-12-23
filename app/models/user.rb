class User < ApplicationRecord
  belongs_to :parent, class_name: "User", optional: true
  has_many :children, class_name: "User", foreign_key: "parent_id"
  has_many :schemes, dependent: :destroy

  has_secure_token :session_token

  belongs_to :role
  has_secure_password validations: false
  # belongs_to :scheme
  has_many :transactions, dependent: :destroy

  def all_descendant_ids
    p "=========all_descendant_ids========="
    p all_descendant_ids
    children.flat_map { |child| [child.id] + child.all_descendant_ids }
  end

  has_one :wallet, dependent: :destroy
  has_many :dmts, foreign_key: :parent_id
  has_many :transaction_commissions, dependent: :destroy
  has_many :user_services, foreign_key: :assignee_id, dependent: :destroy
  has_many :banks, dependent: :destroy
  has_many :fund_requests, dependent: :destroy


  def find_hierarchy
    hierarchy = []
    user = self

    while user.parent.present?
      hierarchy << user.parent
      user = user.parent
    end

    hierarchy
  end


  enum kyc_status: {
    not_started: "not_started",
    send_by: "send_by",
    pending: "pending",
    verified: "verified",
    rejected: "rejected"
  }

end
