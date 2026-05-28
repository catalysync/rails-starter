class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include SetCurrentAttributes
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  # After sign-in, redirect to dashboard instead of root
  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name terms_and_conditions])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
