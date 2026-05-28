class AccountsController < ApplicationController
  layout "dashboard"

  before_action :set_account, only: [ :show, :edit, :update, :destroy, :switch ]

  def index
    authorize Account
    @accounts = current_user.accounts.includes(:owner)
  end

  def new
    @account = Account.new
    authorize @account
  end

  def create
    @account = current_user.owned_accounts.build(account_params)
    authorize @account

    if @account.save
      @account.memberships.find_or_create_by!(user: current_user) do |m|
        m.role = :owner
        m.status = :active
      end
      session[:account_id] = @account.id
      redirect_to account_path(@account), notice: "Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @account
  end

  def edit
    authorize @account
  end

  def update
    authorize @account

    if @account.update(account_params)
      redirect_to account_path(@account), notice: "Account updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @account

    if @account.personal?
      redirect_to accounts_path, alert: "Cannot delete your personal account."
    else
      @account.destroy!
      session.delete(:account_id)
      redirect_to accounts_path, notice: "Account deleted successfully."
    end
  end

  def switch
    authorize @account
    session[:account_id] = @account.id
    redirect_to dashboard_path, notice: "Switched to #{@account.name}."
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :subdomain, :billing_email)
  end
end
