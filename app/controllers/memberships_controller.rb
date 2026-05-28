class MembershipsController < ApplicationController
  layout "dashboard"

  before_action :set_account
  before_action :set_membership, only: [ :update, :destroy ]

  def index
    authorize Membership
    @memberships = @account.memberships.active.includes(:user)
  end

  def update
    authorize @membership

    if @membership.update(membership_params)
      redirect_to account_memberships_path(@account), notice: "Role updated successfully."
    else
      redirect_to account_memberships_path(@account), alert: "Failed to update role."
    end
  end

  def destroy
    authorize @membership

    if @membership.user == current_user
      redirect_to account_memberships_path(@account), alert: "You cannot remove yourself."
      return
    end

    if @membership.owner? && @account.memberships.owner.count <= 1
      redirect_to account_memberships_path(@account), alert: "Cannot remove the last owner."
      return
    end

    @membership.destroy!
    redirect_to account_memberships_path(@account), notice: "Member removed successfully."
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_membership
    @membership = @account.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:role)
  end
end
