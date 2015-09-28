require_relative 'internal'
require_relative 'twitter'
require_relative 'rss'
require_relative 'configuration'

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
      @sources || setup_sources
    end

    def setup_sources
      @sources = [Noizee::Internal.new]

      {
        twitter: Noizee::Twitter,
        rss: Noizee::RSS
      }.each_pair do |key, klass|
        @sources << klass.new if Noizee::Configuration.has_key? key
      end

      @sources
    end
  end
end
