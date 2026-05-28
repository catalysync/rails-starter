class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :owned_accounts, class_name: "Account", foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner

  validates :first_name, :last_name, presence: true

  after_create :create_personal_account

  def personal_account
    owned_accounts.find_by(personal: true)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def platform_admin?
    platform_admin
  end

  def membership_for(account)
    memberships.find_by(account: account)
  end

  private

  def create_personal_account
    account = owned_accounts.create!(name: name, personal: true)
    memberships.create!(account: account, role: :owner, status: :active)
  end
end
