require_relative 'noizee/gestalt'

module Noizee
  module_function

  def make_some_noise *args
    gestalt = Noizee::Gestalt.new

    while true do
      if gestalt.listen then
        gestalt.events.sort_by(&:created_at)
        puts gestalt.events.pop
      end
    end
  end
end
