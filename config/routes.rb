require 'sidekiq/web'
NewsAggregator::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  get '/', :to => redirect('/tomsk')

  get "/:city", :to => 'entries#index', :as => "entries_index", :constraints => { :city => Regexp.new(City.pluck(:slug).join("|")) }
  get '/:city/znaigorod', :to => 'entries#znaigorod'
  get '/:city/:period', :to => 'entries#index', :as => :period, :constraints => { :period => Regexp.new(Entry.available_periods.join("|")) }
  get '/:city/:sort_by', :to => 'entries#index', :as => :sort_by, :constraints => { :sort_by => Regexp.new(Entry.available_sorts.join("|")) }
  get '/about', :to => 'cooperations#about'
  get 'away' => 'away#go'

  namespace :manage do
    root to: "sources#index"
    resources :sources
    resources :cities, :except => [:show]
  end
end
