LOG_FILE = ENV['RACK_ENV'] == 'production' ? STDOUT : "log/#{ENV['RACK_ENV']}.log"

LOGGER = Logger.new(LOG_FILE)

LOGGER.formatter = proc do |severity, datetime, _progname, msg|
  "#{severity[0..0]}, [#{datetime.strftime('%Y-%m-%dT%H:%M:%S.%6N%z '.freeze)}##{$PID}]  #{severity} -- #{msg}\n"
end
