set :application, "AmaraatiS"
set :scm, :git
# set :repository, "git@account.git.beanstalkapp.com:/account/repository.git"
set :repo_url, "git@bitbucket.org:rajashekarg/amaraatis.git"
set :user, "rajashekarg"
set :branch, "master"
set :deploy_to, '/home/ubuntu/code/amaraatis'
set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'
set :rvm_binary, '~/.rvm/bin/rvm'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/videos}
set :log_level, :debug

set :use_sudo, true

# Puma
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :puma_threads, [0, 16]
set :puma_workers, 0

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'db migrate'
  task :migrate do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        with rails_env: fetch(:puma_env) do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  after :finishing, :restart
end


after "deploy:check",     "puma:config"
after "deploy:published", "puma:restart"


# after :restart, :clear_cache do
#     on roles(:app), in: :groups, limit: 3, wait: 10 do
#         # Here we can do anything such as:
#         within release_path do
#           execute :rake, 'tmp:cache:clear'
#         end
#     end
#     invoke 'mongoid:index'
# end

# set :stage, :production
# set :default_stage, "production"
# set :branch, "master"
# set :server_name, "http://ec2-18-223-1-181.us-east-2.compute.amazonaws.com/"

# server "http://ec2-18-223-1-181.us-east-2.compute.amazonaws.com", :app, :web, :db, :primary => true
# set :deploy_to, "/opt/rails"
# set :pty, true

# set :format, :pretty
# server 'ec2-18-223-1-181.us-east-2.compute.amazonaws.com', user: 'ljasti', roles: %w{web app db}, primary: true
# set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"
# set :rails_env, :production


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
