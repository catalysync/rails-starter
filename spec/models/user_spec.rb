require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:accounts).through(:memberships) }
    it { is_expected.to have_many(:owned_accounts).class_name("Account").dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe "callbacks" do
    it "creates a personal account after user creation" do
      user = create(:user)
      expect(user.personal_account).to be_present
      expect(user.personal_account.personal?).to be true
      expect(user.personal_account.name).to eq(user.name)
    end

    it "creates an owner membership for the personal account" do
      user = create(:user)
      membership = user.membership_for(user.personal_account)
      expect(membership).to be_present
      expect(membership.owner?).to be true
      expect(membership.active?).to be true
    end
  end

  describe "#name" do
    it "returns full name" do
      user = build(:user, first_name: "John", last_name: "Doe")
      expect(user.name).to eq("John Doe")
    end
  end

  describe "#platform_admin?" do
    it "returns false by default" do
      user = build(:user)
      expect(user.platform_admin?).to be false
    end

    it "returns true for platform admins" do
      user = build(:user, :platform_admin)
      expect(user.platform_admin?).to be true
    end
  end

  describe "#membership_for" do
    it "returns the membership for a given account" do
      user = create(:user)
      account = user.personal_account
      expect(user.membership_for(account)).to be_present
      expect(user.membership_for(account).owner?).to be true
    end

    it "returns nil for accounts the user is not a member of" do
      user = create(:user)
      other_user = create(:user)
      expect(user.membership_for(other_user.personal_account)).to be_nil
    end
  end
end
