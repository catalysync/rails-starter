class Account < ApplicationRecord
  has_paper_trail

  belongs_to :owner, class_name: "User"
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
  validates :subdomain, uniqueness: true, allow_nil: true,
            format: { with: /\A[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/, message: "must be lowercase alphanumeric and hyphens only" },
            if: -> { subdomain.present? }

  scope :personal, -> { where(personal: true) }
  scope :team, -> { where(personal: false) }

  def personal?
    personal
  end

  def team?
    !personal
  end
end
