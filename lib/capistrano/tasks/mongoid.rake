namespace :mongoid do
  desc "Create mongodb index"
  task :index do
    on roles(:mongoid) do |host|
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:mongoid:create_indexes"
        end
      end
    end
  end
end