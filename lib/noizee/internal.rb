module Noizee
  class Internal
    EVENTS = Array.new

    def self.event text
      EVENTS << Event.new(source: :noizee, created_by: ENV['USER'], created_at: Time.now, full_text: text)
    end

    def get
      if EVENTS.empty? then
        Array.new
      else
        [EVENTS.pop]
      end
    end
  end
end
