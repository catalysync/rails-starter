class Current < ActiveSupport::CurrentAttributes
  attribute :user, :account, :membership

  def roles
    membership&.role
  end

  def admin?
    membership&.admin? || membership&.owner?
  end

  def owner?
    membership&.owner?
  end

  def platform_admin?
    user&.platform_admin?
  end
end
