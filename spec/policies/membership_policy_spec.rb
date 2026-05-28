require "rails_helper"

RSpec.describe MembershipPolicy, type: :policy do
  let(:owner) { create(:user) }
  let(:account) { create(:account, owner: owner) }
  let(:member_user) { create(:user) }
  let!(:owner_membership) { account.memberships.create!(user: owner, role: :owner, status: :active) }
  let!(:member_membership) { account.memberships.create!(user: member_user, role: :member, status: :active) }

  before do
    Current.user = owner
    Current.account = account
    Current.membership = owner_membership
  end

  describe "#index?" do
    it "allows any member to view" do
      expect(described_class.new(owner, member_membership).index?).to be true
    end
  end

  describe "#update?" do
    it "allows owners to change others' roles" do
      policy = described_class.new(owner, member_membership)
      expect(policy.update?).to be true
    end

    it "denies changing own role" do
      policy = described_class.new(owner, owner_membership)
      expect(policy.update?).to be false
    end

    it "denies regular members from changing roles" do
      Current.membership = member_membership
      policy = described_class.new(member_user, owner_membership)
      expect(policy.update?).to be false
    end
  end

  describe "#destroy?" do
    it "allows owners to remove other members" do
      policy = described_class.new(owner, member_membership)
      expect(policy.destroy?).to be true
    end

    it "denies removing self" do
      policy = described_class.new(owner, owner_membership)
      expect(policy.destroy?).to be false
    end
  end
end
