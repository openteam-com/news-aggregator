class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_city

  def current_city
    params[:city] || 'Томск'
  end
end
