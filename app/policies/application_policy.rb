# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private

  def platform_admin?
    user&.platform_admin?
  end

  def current_membership
    Current.membership
  end

  def current_account
    Current.account
  end

  def admin_or_owner?
    current_membership&.admin? || current_membership&.owner?
  end

  def owner?
    current_membership&.owner?
  end

  def member?
    current_membership.present?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
