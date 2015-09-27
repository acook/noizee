require 'virtus'
require_relative 'formatter'

class Event
  include Virtus.model

  attribute :created_at, Time
  attribute :created_by, String
  attribute :full_text, String
  attribute :source, Symbol

  def to_s
    Noizee::Formatter.new(self).format
  end
end
