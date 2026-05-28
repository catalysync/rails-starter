# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    member?
  end

  def create?
    true
  end

  def update?
    admin_or_owner?
  end

  def destroy?
    owner? && !record.personal?
  end

  def switch?
    user.accounts.exists?(record.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:memberships).where(memberships: { user_id: user.id })
    end
  end
end
