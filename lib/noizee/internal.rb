module Noizee
  class Internal
    @events = Array.new

    class << self
      def event text
        events << Event.new(source: :noizee, created_by: ENV['USER'], created_at: Time.now, full_text: text)
      end
      attr_accessor :events
    end

    def get
      self.class.events.tap{ self.class.events = Array.new }
    end
  end
end
