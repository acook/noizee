require_relative 'internal'
require_relative 'twitter'
require_relative 'rss'

module Noizee
  class Gestalt
    def listen
      if events.empty? then
        sources.each do |source|
          events.concat source.get
        end
      end

      events.sort_by!(&:created_at).reverse!

      sleep 1
      !events.empty?
    end

    def pop
      events.pop
    end

    def events
      @events ||= Array.new
    end

    def sources
      @sources ||= setup_sources
    end

    def setup_sources
      [
        Noizee::Internal.new,
        Noizee::Twitter.new,
        Noizee::RSS.new
      ]
    end
  end
end
