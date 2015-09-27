require 'yaml'
require 'twitter'

module Noizee
  class Twitter
    def initialize
      conf = YAML.load_file "#{ENV['HOME']}/.noizee"
      @client = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = conf[:consumer_key]
        config.consumer_secret     = conf[:consumer_secret]
        config.access_token        = conf[:access_token]
        config.access_token_secret = conf[:access_token_secret]
      end
    end

    def get
      return Array.new if limit?
      checked!

      @client.home_timeline(options).map do |t|
        options[:since_id] = [options[:since_id], t.id].max
        [t.created_at.getlocal.strftime('%H:%M.%S'), t.user.name, t.full_text].join ' : '
      end
    rescue ::Twitter::Error::TooManyRequests
      rate_limit!
      Array.new
    end

    def limit?
      diff = Time.now - last_check
      #p({delay: delay, diff: diff})
      diff < delay
    end

    def rate_limit!
      warn "Twitter is rate-limiting your account."
      @delay = 60 * 60 # 1 hour
    end

    def reset_limit!
      @delay = 2 * 60 # two minutes
    end

    def delay
      @delay || reset_limit!
    end

    def options
      @options ||= Hash.new(0).merge({count: 5})
    end

    def last_check
      @last_check || checked!
    end

    def checked!
      reset_limit!
      @last_check = Time.now
    end
  end
end

