set :deploy_to, '/home/deploy/apps/legacy-data.mobilityhouse.com'

set :stage, :production
set :keep_releases, 3
role :app, %w{patti.servers.mobilityhouse.com}
role :web, %w{patti.servers.mobilityhouse.com}
role :db,  %w{patti.servers.mobilityhouse.com}

set :ssh_options, { user: 'deploy', forward_agent: true }
