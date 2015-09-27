require 'rss'
require 'open-uri'
require 'cgi'

module Noizee
  class RSS

    def initialize
      @clients = Array.new
      configs  = [Noizee::Configuration.rss].flatten

      configs.each do |config|
        clients << setup_client(config)
      end

      checked!
      @delay = 10 # seconds
      @since = Time.now - (60 * 60)
    end
    attr_accessor :clients, :delay, :last_check

    def setup_client config
      ConfigModule::ConfigOption.new config
    end

    def get
      return Array.new if too_soon?
      checked!
      next_since = @since

      clients.map do |client|
        open(client.url) do |rss|
          feed = ::RSS::Parser.parse(rss)
          feed.items.map do |i|

            date = i.date || feed.channel.date

            if date > @since then
              next_since = [next_since, date].max

              event = Event.new(
                source: :rss,
                created_at: (i.date || feed.channel.date),
                created_by: (i.author || client.alias || feed.channel.title),
                full_text: CGI.unescapeHTML(i.description || i.title)
              )
            end
          end
        end
      end.flatten.compact.tap{ @since = next_since if next_since }
    end

    def too_soon?
      (Time.now - last_check) < delay
    end

    def checked!
      @last_check = Time.now
    end

  end
end
