require 'sidekiq/web'
NewsAggregator::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root to: 'entries#index'
  get 'away' => 'away#go'
  get '/znaigorod', :to => 'entries#znaigorod'
  get ':period', :to => 'entries#index', :as => :period, :constraints => {:period => Regexp.new(Entry.available_periods.join("|"))}
  get ':sort_by', :to => 'entries#index', :as => :sort_by, :constraints => {:sort_by => Regexp.new(Entry.available_sorts.join("|"))}

  get ':kind', :to => 'suggested_entries#index', :as => :suggested_list, :constraints => {:kind => Regexp.new(SuggestedEntry.available_types.join("|"))}
  resources :suggested_entries, :only => [:new, :create]

  namespace :manage do
    resources :sources
    resources :suggested_entries, :except => [:new, :create,:show] do
      get :approve
      get ':entry_type', :to => 'suggested_entries#entry_type', :on => :collection, :as => :entry_type, :constraints => {:entry_type => Regexp.new(SuggestedEntry.available_types.join("|"))}
    end
    root to: "sources#index"
  end

  %w[about].each do |method|
    get method => "cooperations##{method}"
  end
end
