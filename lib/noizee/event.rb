require 'virtus'

class Event
  include Virtus.model

  attribute :created_at, Time
  attribute :created_by, String
  attribute :full_text, String

  SUMMARY_LENGTH = 141

  def to_s
    [created_at.getlocal.strftime('%H:%M.%S'), created_by, summary].join ?\t
  end

  def summary
    if text.length < SUMMARY_LENGTH then
      text
    else
      text[0..(text_limit - 3)] + "..."
    end
  end

  def text
    @text ||= full_text.strip.gsub(/\s+/, ' ')
  end
end
