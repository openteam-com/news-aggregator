# encoding: utf-8
class SuggestedEntriesController < ApplicationController
  helper_method :page

  def index
    @entries = SuggestedEntry.send(params[:kind]).page(page).per(per_page)
    render :partial => 'entries_body' and return if request.xhr?
  end

  def new
    @suggested_entry = SuggestedEntry.new
  end

  def create
    @suggested_entry = SuggestedEntry.new(params[:suggested_entry])
    if @suggested_entry.save
      @suggested_entry.delay.set_title
      @suggested_entry.delay.set_favicon
      flash[:notice] = "Ваша ссылка добавлена"
      redirect_to root_path
    else
      flash[:alert] = "Ваша ссылка не была добавлена"
      redirect_to root_path
    end
  end

  protected

  def page
    page = params[:page].to_i
    page.zero? ? 1 : page
  end

  def per_page
    15
  end
end
