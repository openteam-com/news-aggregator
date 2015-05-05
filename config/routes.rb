require 'sidekiq/web'
NewsAggregator::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  #root to: 'entries#index'

  get '/', :to => redirect('/tomsk')

  get "/:city" => 'entries#index', :as => "entries_index", :constraints => { :city => Regexp.new(City.pluck(:slug).join("|")) } rescue true

  get '/:city/znaigorod', :to => 'entries#znaigorod', :constraints => { :city => Regexp.new(City.pluck(:slug).join("|")) } rescue true
  get '/:city/:period', :to => 'entries#index', :as => :period, :constraints => { :period => Regexp.new(Entry.available_periods.join("|")) }
  get '/:city/:sort_by', :to => 'entries#index', :as => :sort_by, :constraints => { :sort_by => Regexp.new(Entry.available_sorts.join("|")) }
  get 'away' => 'away#go'

  %w[about].each do |method|
    get method => "cooperations##{method}"
  end

  namespace :manage do
    root to: "sources#index"

    resources :sources
    resources :cities, :except => [:show]
  end
end
