class BlogController < ApplicationController
  skip_before_action :authenticate_user!

  layout "marketing"

  def index
  end

  def show
    @slug = params[:id]
  end
end
