require_relative 'noizee/gestalt'

module Noizee
  module_function

  def make_some_noise *args
    gestalt = Noizee::Gestalt.new

    while true do
      puts gestalt.pop if gestalt.listen
    end
  end
end
