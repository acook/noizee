require 'yaml'
require 'twitter'
require_relative 'event'
require_relative 'configuration'

# The Twitter gem is using a deprecated constant
# This silences the warning message
Faraday.const_set :Builder, Faraday::RackBuilder

module Noizee
  class Twitter
    def initialize
      @clients = Array.new
      configs  = Array[Noizee::Configuration.twitter]

      configs.each do |config|
        clients << setup_client(config)
      end

      checked!
    end
    attr_accessor :clients, :delay, :last_check

    def setup_client config
      ::Twitter::REST::Client.new do |twitter|
        twitter.consumer_key        = config.consumer_key
        twitter.consumer_secret     = config.consumer_secret
        twitter.access_token        = config.access_token
        twitter.access_token_secret = config.access_token_secret
      end
    end

    def get
      return Array.new if too_soon?
      checked!

      clients.map do |client|
        client.home_timeline(options).map do |t|
          options[:since_id] = [options[:since_id], t.id].max
          Event.new source: :twitter, created_at: t.created_at, created_by: t.user.name, full_text: t.full_text
        end
      end.flatten
    rescue ::Twitter::Error::TooManyRequests
      rate_limit!
      Array.new
    rescue ::Twitter::Error => error
      Noizee::Internal.event error.message
      Array.new
    end

    def options
      @options ||= Hash.new(0).merge({count: 5})
    end

    def too_soon?
      (Time.now - last_check) < delay
    end

    def rate_limit!
      Noizee::Internal.event 'Twitter is rate-limiting your account.'
      @delay = 60 * 60 # 1 hour, Twitter resets the rate limit after an hour
    end

    def checked!
      reset_limit!
      @last_check = Time.now
    end

    def reset_limit!
      @delay = 60 # one minute
    end

  end
end

