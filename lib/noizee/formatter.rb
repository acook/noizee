require 'remedy'

module Noizee
  class Formatter

    PREFIX = ?\u2520
    SEP    = ?\u2500
    LSEP   = ?\u2574
    RSEP   = ?\u2576
    SUFFIX = ?\u257C
    SPACE  = ' '
    TRUNC  = ?\u2026

    COLOR = {
      # attributes
      normal:     0,
      bold:       1,
      # foreground
      fg_black:   30,
      fg_red:     31,
      fg_green:   32,
      fg_yellow:  33,
      fg_blue:    34,
      fg_magenta: 35,
      fg_cyan:    36,
      fg_white:   '38;5;15',
      fg_grey:    '38;5;243',
      fg_orange:  '38;5;202',
      # background
      bg_black:   40,
      bg_red:     41,
      bg_green:   42,
      bg_yellow:  43,
      bg_blue:    44,
      bg_magenta: 45,
      bg_cyan:    46,
      bg_white:   47
    }

    SOURCE_COLOR = {
      noizee:  COLOR[:fg_orange],
      twitter: '38;5;81'
    }

    COLOR.merge! SOURCE_COLOR

    def initialize event
      @event = event
    end
    attr_accessor :event

    def format
      [
        color(:fg_white),
        PREFIX, SEP,
        LSEP, color(:fg_grey), at, color(:fg_white), RSEP,
        LSEP, color(event.source), by, color(:fg_white), RSEP,
        SEP,
        LSEP, color(:normal), truncated_text
      ].join
    end

    def headroom
      [
        PREFIX, SEP,
        LSEP, at, RSEP,
        LSEP, by, RSEP,
        SEP,
        LSEP
      ].join.length + 1
    end

    def color name
      Remedy::ANSI::Color.c COLOR[name]
    end

    def at
      event.created_at.getlocal.strftime('%H:%M')
    end

    def by
      event.created_by.to_s
    end

    def text
      @cleaned_text ||= event.full_text.gsub(/\s+/, ' ').strip
    end

    def truncated_text
      if (text.length + headroom) < Remedy::Console.size.last then
        text
      else
        text[0..(Remedy::Console.size.last - (TRUNC.length + headroom))] + TRUNC
      end
    end
  end
end
