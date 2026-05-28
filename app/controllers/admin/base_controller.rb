module Admin
  class BaseController < ApplicationController
    layout "dashboard"

    before_action :require_platform_admin!

    private

    def require_platform_admin!
      unless current_user&.platform_admin?
        redirect_to dashboard_path, alert: "You don't have access to the admin panel."
      end
    end
  end
end
