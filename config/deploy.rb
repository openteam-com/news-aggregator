require 'openteam/capistrano/recipes'
require 'sidekiq/capistrano'
require 'whenever/capistrano'

set :default_stage, 'production'

set :shared_children, fetch(:shared_children) + %w[config/sunspot.yml config/twitter.yml config/facebook.yml]
