require_relative 'noizee/gestalt'
require_relative 'noizee/internal'

module Noizee
  module_function

  def make_some_noise *args
    gestalt = Noizee::Gestalt.new
    Noizee::Internal.event "Noizee initialized."

    while true do
      puts gestalt.pop if gestalt.listen
    end
  end

end
