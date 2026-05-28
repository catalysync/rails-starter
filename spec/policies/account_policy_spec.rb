require "rails_helper"

RSpec.describe AccountPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:account) { create(:account, owner: user) }

  before do
    account.memberships.create!(user: user, role: :owner, status: :active)
    Current.user = user
    Current.account = account
    Current.membership = user.membership_for(account)
  end

  subject { described_class.new(user, account) }

  describe "#show?" do
    it "allows members to view" do
      expect(subject.show?).to be true
    end
  end

  describe "#update?" do
    it "allows owners to update" do
      expect(subject.update?).to be true
    end

    it "allows admins to update" do
      Current.membership = create(:membership, :admin, user: user, account: create(:account, owner: user))
      expect(subject.update?).to be true
    end

    it "denies regular members" do
      member = create(:user)
      account.memberships.create!(user: member, role: :member, status: :active)
      Current.user = member
      Current.membership = member.membership_for(account)
      policy = described_class.new(member, account)
      expect(policy.update?).to be false
    end
  end

  describe "#destroy?" do
    it "allows owners to destroy team accounts" do
      team_account = create(:account, :team, owner: user)
      team_account.memberships.create!(user: user, role: :owner, status: :active)
      Current.membership = user.membership_for(team_account)
      policy = described_class.new(user, team_account)
      expect(policy.destroy?).to be true
    end

    it "denies destroying personal accounts" do
      personal = user.personal_account
      Current.membership = user.membership_for(personal)
      policy = described_class.new(user, personal)
      expect(policy.destroy?).to be false
    end
  end

  describe "#switch?" do
    it "allows members to switch" do
      expect(subject.switch?).to be true
    end

    it "denies non-members" do
      other_user = create(:user)
      policy = described_class.new(other_user, account)
      expect(policy.switch?).to be false
    end
  end
end
