require 'virtus'
require 'remedy'

class Event
  include Virtus.model

  attribute :created_at, Time
  attribute :created_by, String
  attribute :full_text, String
  attribute :source, Symbol

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

  COLOR.merge SOURCE_COLOR

  def formatted_output
    head_length = [
      PREFIX, SEP,
      LSEP, at, RSEP,
      LSEP, by, RSEP,
      SEP,
      LSEP
    ].join.length

    [
      color(COLOR[:fg_white]),
      PREFIX, SEP,
      LSEP, color(COLOR[:fg_grey]), at, color(COLOR[:fg_white]), RSEP,
      LSEP, color(SOURCE_COLOR[source]), by, color(COLOR[:fg_white]), RSEP,
      SEP,
      LSEP, color(COLOR[:normal]), trunc(summary, head_length),
      color(COLOR[:normal])
    ].join
  end
  alias_method :to_s, :formatted_output

  def color code
    Remedy::ANSI::Color.c code
  end

  def at
    created_at.getlocal.strftime('%H:%M')
  end

  def by
    created_by.to_s
  end

  def summary
    cleaned_text
  end

  def cleaned_text
    @cleaned_text ||= full_text.strip.gsub(/\s+/, ' ')
  end

  def trunc text, headroom = 0
    if (text.length + headroom) < Remedy::Console.size.last then
      text
    else
      text[0..(Remedy::Console.size.last - (TRUNC.length + headroom + 1))] + TRUNC
    end
  end
end
