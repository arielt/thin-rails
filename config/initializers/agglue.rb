APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")
puts "config #{APP_CONFIG}"

puts "loading redis #{APP_CONFIG['cache']['ip']}:#{APP_CONFIG['cache']['port']}"
$redis = Redis.new(:host => APP_CONFIG['redis'], :port => 6379)

puts "loading instance #{APP_CONFIG['instance']}"
$instance = APP_CONFIG['instance']
$instance ||= 'Unknown'

# metrics
require "nunes"
statsd = Statsd.new APP_CONFIG['metrics']['ip'], APP_CONFIG['metrics']['port']
Nunes.subscribe(statsd)

Rails.logger = ActFluentLoggerRails::Logger.
new(log_tags: {
      instance: $instance,
      ip: :ip,
      ua: :user_agent,
      uid: ->(request) { request.session[:uid] }
})

Rails.logger.debug "starting RailsApp instance #{$instance}"
Rails.logger.flush
