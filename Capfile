# # Load DSL and set up stages

require "capistrano/setup"
require "capistrano/deploy"
# require "capistrano/scm/git"
require "capistrano/rvm"
require "capistrano/bundler"
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
# install_plugin Capistrano::Puma::Nginx
# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
