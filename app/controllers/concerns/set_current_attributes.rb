module SetCurrentAttributes
  extend ActiveSupport::Concern

  included do
    before_action :set_current_attributes
    helper_method :current_account, :current_membership
  end

  def current_account
    Current.account
  end

  def current_membership
    Current.membership
  end

  private

  def set_current_attributes
    return unless user_signed_in?

    # Eager-load accounts + memberships to avoid N+1 in sidebar/switcher
    current_user.accounts.load
    current_user.memberships.load

    Current.user = current_user
    Current.account = resolve_account
    Current.membership = current_user.membership_for(Current.account) if Current.account
    ActsAsTenant.current_tenant = Current.account
  end

  def resolve_account
    if params[:account_id].present?
      account = current_user.accounts.find_by(id: params[:account_id])
      session[:account_id] = account.id if account
      account
    elsif session[:account_id].present?
      current_user.accounts.find_by(id: session[:account_id])
    else
      current_user.personal_account
    end
  end
end
