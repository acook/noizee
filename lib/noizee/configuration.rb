require 'config_module'

module Noizee
  module Configuration
    extend ConfigModule
    config_file "#{ENV['HOME']}/.noizee"
  end
end
