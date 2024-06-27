# require 'sidekiq/web'
# Rails.application.routes.draw do
#   mount Sidekiq::Web => '/sidekiq'
# end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0') }
end
