class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :page_meta

  def page_meta
    City.find_by_slug(params[:city])
  end
end
