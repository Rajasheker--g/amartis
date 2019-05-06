require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}
     
module AmaraatiS
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # deplyement
    # %w(app lib vendor).each do |d|
    #     (asset_paths, precompile_paths) = Dir[Rails.root.join(*%W(#{d} assets ** *)).to_s].partition {|f| File.directory?(f) }
    #     config.assets.paths += asset_paths
    #     config.assets.precompile += precompile_paths
    # end
    # config.cache_classes = true
    config.generators do |g|
        # g.stylesheets false
        # g.javascripts false
        # g.orm :active_record
        g.orm :mongoid
    end
    cache_classes = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host:'localhost', port: '3000' }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default :charset => "utf-8"

    config.action_mailer.smtp_settings = {
        address:              'smtp.gmail.com',
        port:                 587,
        domain:               'gmail.com',
        user_name:            'amaraatis.reddy@gmail.com',
        password:             'jasti.reddy1',
        authentication:       'plain',
        enable_starttls_auto: true
    }
  end
end
