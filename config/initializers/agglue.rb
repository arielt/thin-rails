puts "loading config"
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")

puts "loading redis"
$redis = Redis.new(:host => APP_CONFIG['redis'], :port => 6379)

puts "loading instance"
$instance = APP_CONFIG['instance']
$instance ||= 'Unknown'

# metrics
require "nunes"
statsd = Statsd.new APP_CONFIG['metric'], 8125
Nunes.subscribe(statsd)

Rails.logger = ActFluentLoggerRails::Logger.
new(log_tags: {
      instance: $instance,
      ip: :ip,
      ua: :user_agent,
      uid: ->(request) { request.session[:uid] }
})

Rails.logger.debug "starting RubyApp instance #{$instance}"
Rails.logger.flush
