require_relative '../noizee'
require 'config_module'

module Noizee
  module Configuration
    extend ConfigModule
    config_file Noizee::CONFIG_PATH
  end
end
