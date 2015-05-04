working_directory File.expand_path('../../', __FILE__)

preload_app true

require_relative 'logging'
logger LOGGER

worker_processes Integer(ENV.fetch('UNICORN_WORKER_PROCESSES', 4))
timeout Integer(ENV.fetch('UNICORN_WORKER_TIMEOUT', 45))
