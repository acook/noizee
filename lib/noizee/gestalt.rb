require_relative 'twitter'

module Noizee
  class Gestalt
    def listen
      if events.empty? then
        events.concat twitter.get
      end

      events.sort_by(&:created_at)

      sleep 1
      !events.empty?
    end

    def pop
      events.pop
    end

    def events
      @events ||= Array.new
    end

    def twitter
      @twitter ||= Noizee::Twitter.new
    end
  end
end
