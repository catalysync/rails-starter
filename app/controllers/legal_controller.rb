class LegalController < ApplicationController
  skip_before_action :authenticate_user!

  layout "marketing"

  def privacy
  end

  def terms
  end
end
