require 'run_later/worker'
require 'run_later/instance_methods'
require 'run_later/cleanup'

module RunLater
  if defined?(Rails) && Rails::VERSION::MAJOR > 2
    require 'run_later/railtie'
    RUNLATER_LOGGER = Rails.logger
  else
    RUNLATER_LOGGER = ::RAILS_DEFAULT_LOGGER
  end
end

ActionController::Base.send(:include, RunLater::InstanceMethods) if defined?(ActionController)

# Make run_later available both as instance and class methods
if defined?(ActiveRecord)
  ActiveRecord::Base.send(:include, RunLater::InstanceMethods)
  ActiveRecord::Base.extend(RunLater::InstanceMethods)
  ActiveRecord::Observer.send(:include, RunLater::InstanceMethods)
  ActiveRecord::Observer.extend(RunLater::InstanceMethods)
end
