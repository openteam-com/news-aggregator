class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :page_meta, :current_city

  def page_meta
    @page_meta = City.find_by_slug(current_city)
  end

  def current_city
   @current_city = params[:city] || 'tomsk'
  end
end
