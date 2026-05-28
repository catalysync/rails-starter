class Membership < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :account

  enum :role, { member: "member", admin: "admin", owner: "owner" }
  enum :status, { active: "active", invited: "invited", deactivated: "deactivated" }

  validates :user_id, uniqueness: { scope: :account_id }
  validates :role, presence: true
  validates :status, presence: true

  scope :active, -> { where(status: :active) }
end
