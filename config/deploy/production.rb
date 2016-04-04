set :deploy_to, '/home/deploy/apps/legacy-data.mobilityhouse.com'

set :stage, :production
set :keep_releases, 3
role :app, %w{legacy-data.mobilityhouse.com}
role :web, %w{legacy-data.mobilityhouse.com}
role :db,  %w{legacy-data.mobilityhouse.com}

set :ssh_options, { user: 'deploy', forward_agent: true }
