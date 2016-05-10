lock '3.4.0'

set :application, 'csv_viewer'
set :repo_url, 'git@github.com:mobilityhouse/csv_viewer.git'
set :branch, 'master'
set :linked_files, %w{
  config/database.yml
}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :bundle_binstubs, nil
set :bundle_path, -> { shared_path.join('vendor/bundle') }
set :keep_releases, 3
set :pty, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

desc 'Setup database'
task :db_setup do
  on roles(:db) do
    within release_path do
      with rails_env: (fetch(:rails_env) || fetch(:stage)) do
        execute :rake, 'db:setup' # This creates the database tables AND seeds
      end
    end
  end
end