require "rails_helper"

RSpec.describe Account, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:owner).class_name("User") }
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:memberships) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    context "subdomain format" do
      it "allows valid subdomains" do
        account = build(:account, subdomain: "my-team")
        expect(account).to be_valid
      end

      it "allows nil subdomain" do
        account = build(:account, subdomain: nil)
        expect(account).to be_valid
      end

      it "rejects invalid subdomains" do
        account = build(:account, subdomain: "My Team!")
        expect(account).not_to be_valid
      end

      it "rejects subdomains starting with hyphen" do
        account = build(:account, subdomain: "-team")
        expect(account).not_to be_valid
      end
    end
  end

  describe "scopes" do
    let(:user) { create(:user) }

    it ".personal returns only personal accounts" do
      # User auto-creates a personal account
      expect(Account.personal.count).to eq(1)
      expect(Account.personal.first.personal?).to be true
    end

    it ".team returns only team accounts" do
      create(:account, :team, owner: user)
      expect(Account.team.count).to eq(1)
      expect(Account.team.first.team?).to be true
    end
  end

  describe "#personal? and #team?" do
    it "returns true for personal accounts" do
      account = build(:account, personal: true)
      expect(account.personal?).to be true
      expect(account.team?).to be false
    end

    it "returns true for team accounts" do
      account = build(:account, personal: false)
      expect(account.personal?).to be false
      expect(account.team?).to be true
    end
  end
end
