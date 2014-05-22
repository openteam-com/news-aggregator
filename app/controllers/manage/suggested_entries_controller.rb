# encoding: utf-8
class Manage::SuggestedEntriesController < Manage::ApplicationController
  helper_method :search_query
  def index
    session[:return_to] = request.url
    @new_interesting_entries = SuggestedEntry.new_interesting
    @new_interview_entries = SuggestedEntry.new_interview
    @new_article_entries = SuggestedEntry.new_article
  end

  def entry_type
    session[:return_to] = request.url
    @suggested_entries = if params['utf8']
                           HasSearcher.searcher(:suggested_entries, :q => search_query).send(params[:entry_type]).results
                         else
                           SuggestedEntry.send(params[:entry_type])
                         end
  end

  def edit
    session[:return_to] = request.referer
    @suggested_entry = SuggestedEntry.find(params[:id])
  end

  def update
    @suggested_entry = SuggestedEntry.find(params[:id])
    if @suggested_entry.update_attributes(params[:suggested_entry])
      flash[:notice] = "Информация изменена"
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "Нельзя сохранить"
      render :action => :edit
    end
  end

  def destroy
    @suggested_entry = SuggestedEntry.find(params[:id])
    @suggested_entry.destroy
    redirect_to session.delete(:return_to)
  end

  def approve
    @suggested_entry = SuggestedEntry.find(params[:suggested_entry_id])
    @suggested_entry.entry_type = params[:entry_type]
    @suggested_entry.save
    redirect_to [:manage, :suggested_entries]
  end

  def search_query
    params.try(:[], 'search').try(:[], 'q')
  end
end
