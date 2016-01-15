RailsTemplateCache.setup do |config|
  config.templates_path = File.join( ['app', 'assets', 'javascripts', 'angular', 'templates'] )
  config.extensions = %w(erb haml html slim)
  config.compress_html = false
end