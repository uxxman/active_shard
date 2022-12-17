require_relative 'middleware'

module ActiveShard
  class Railtie < Rails::Railtie
    initializer 'active_shard.configure_middleware' do |app|
      app.middleware.insert_before 0, Middleware
    end

    config.to_prepare do
      require_relative 'record'
    end
  end
end
