module Noizee
  module_function

  CONFIG_PATH = "#{ENV['HOME']}/.noizee"

  def make_some_noise *args
    require 'fileutils'
    FileUtils.touch Noizee::CONFIG_PATH
    require_relative 'noizee/gestalt'
    gestalt = Noizee::Gestalt.new
    require_relative 'noizee/internal'
    Noizee::Internal.event "Noizee initialized."

    while true do
      puts gestalt.pop if gestalt.listen
    end
  end

end
