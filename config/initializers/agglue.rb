puts "loading config"
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")

puts "loading redis"
$redis = Redis.new(:host => APP_CONFIG['redis'], :port => 6379)

