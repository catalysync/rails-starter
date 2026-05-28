# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  def index?
    member?
  end

  def update?
    return false if record.user == user # cannot change own role
    admin_or_owner?
  end

  def destroy?
    return false if record.user == user # cannot remove self
    admin_or_owner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(account: Current.account)
    end
  end
end
