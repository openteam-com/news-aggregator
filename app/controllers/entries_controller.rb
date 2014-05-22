# encoding: utf-8
class EntriesController < ApplicationController
  helper_method :page, :current_period, :current_source, :search_query, :current_sort

  def index
    collection = if params['utf8']
      HasSearcher.searcher(:entries, :q => search_query, :source => current_source)
        .send(current_period).send(current_sort)
        .paginate(:page => page, :per_page => per_page).hits
    else
      Entry.send(current_period).send(current_sort).page(page).per(per_page)
    end
    @entries_wrapper = EntriesWrapper.new(collection)
    render :partial => 'entries_body' and return if request.xhr?
  end

  def znaigorod
     @entries_wrapper = EntriesWrapper.new(Entry.send('newest').send('rating').page(1).per(6))
     render layout: false
  end

  protected

  def page
    page = params[:page].to_i
    page.zero? ? 1 : page
  end

  def per_page
    15
  end

  def current_period
    (Entry.available_periods && params[:period]) || Entry.available_periods.first
  end

  def current_sort
    (Entry.available_sorts && params[:sort_by]) || Entry.available_sorts.first
  end

  def search_query
    params.try(:[], 'search').try(:[], 'q')
  end

  def current_source
    params.try(:[], 'search').try(:[], 'source')
  end
end
