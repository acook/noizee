require_relative 'noizee/gestalt'

module Noizee
  module_function

  def make_some_noise *args
    gestalt = Noizee::Gestalt.new

    while true do
      if gestalt.listen then
        puts gestalt.events.pop
      end
    end
  end
end
