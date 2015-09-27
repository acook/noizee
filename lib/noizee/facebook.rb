require 'koala'
require_relative 'event'
require_relative 'configuration'

module Noizee
  class Facebook
    def initialize
      Noizee::Internal.event 'Intializing Facebook integration'

      @clients = Array.new
      configs = Array[Noizee::Configuration.facebook]

      configs.each do |config|
        clients << setup_client(config)
      end

      checked!
    end
    attr_accessor :clients, :delay, :last_check

    def setup_client config
      ::Koala::Facebook::API.new config.access_token
    end

    def get
      #return Array.new if too_soon?
      checked!

      clients.map do |client|
        client.get_connection('me', 'home', options).map do |t|
          options[:since] = [options[:since], t.created_time].max
          Event.new source: :facebook, created_at: t.created_at, created_by: t.user.name, full_text: t.full_text
        end
      end.flatten
    end

    def options
      @options ||= {limit: 5, since: (Time.now.to_i - 600)}
    end

    def too_soon?
      (Time.now - last_check) < delay
    end

    def rate_limit!
      Noizee::Internal.event 'Facebook is rate-limiting your account.'
      #@delay = 60 * 60 # 1 hour,  resets the rate limit after an hour
    end

    def checked!
      reset_limit!
      @last_check = Time.now
    end

    def reset_limit!
      @delay = 30 # one minute
    end

  end
end
