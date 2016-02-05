  Rails.application.config.middleware.use(Rack::Config) do |env|
    env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api'
  end