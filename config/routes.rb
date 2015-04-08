require 'sidekiq/web'
NewsAggregator::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root to: 'entries#index'

  get '/znaigorod', :to => 'entries#znaigorod'
  get ':period', :to => 'entries#index', :as => :period, :constraints => {:period => Regexp.new(Entry.available_periods.join("|"))}
  get ':sort_by', :to => 'entries#index', :as => :sort_by, :constraints => {:sort_by => Regexp.new(Entry.available_sorts.join("|"))}
  get 'away' => 'away#go'

  %w[about].each do |method|
    get method => "cooperations##{method}"
  end

  namespace :manage do
    root to: "sources#index"

    resources :sources
  end
end
