require "rails_helper"

RSpec.describe Membership, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:account) }
  end

  describe "validations" do
    subject { build(:membership) }

    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:account_id) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:role).with_values(member: "member", admin: "admin", owner: "owner") }
    it { is_expected.to define_enum_for(:status).with_values(active: "active", invited: "invited", deactivated: "deactivated") }
  end

  describe "scopes" do
    it ".active returns only active memberships" do
      user = create(:user)
      account = user.personal_account
      # The auto-created membership is active
      expect(account.memberships.active.count).to eq(1)
    end
  end
end
