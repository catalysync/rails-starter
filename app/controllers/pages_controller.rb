class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  layout "marketing"

  def landing
  end

  def pricing
  end

  def contact
  end

  def changelog
  end
end
