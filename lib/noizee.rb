module Noizee
  module_function

  CONFIG_PATH = "#{ENV['HOME']}/.noizee"

  def make_some_noise *args
    require 'fileutils'
    FileUtils.touch Noizee::CONFIG_PATH
    require_relative 'noizee/gestalt'
    gestalt = Noizee::Gestalt.new
    require_relative 'noizee/internal'
    Noizee::Internal.event "Noizee initialized."

    Remedy::Keyboard.raise_on_control_c!
    Remedy::ANSI.cursor.hide!

    while true do
      puts gestalt.pop if gestalt.listen
      interact
    end

  rescue Remedy::Keyboard::ControlC
    quit "Noizee user pressed Ctrl-C. Exiting."
  ensure
    Remedy::ANSI.cursor.show!
  end

  def interact
    key = get_key

    case key
    when nil
      return
    when ?q
      quit "Noizee user pressed 'q'. Exiting."
    when ?p
      Remedy::Keyboard.get # pause until keypress
    end
  end

  def get_key
    key = nil
    input = raw_get
    if input
      key = Remedy::Keyboard.parse input
    end
    key
  end

  def raw_get
    Remedy::Console.raw do
      input = STDIN.read_nonblock(1)
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
      input
    end
  end

  def quit message
    gestalt.events.clear
    Noizee::Internal.event message
    puts gestalt.pop
    exit 0
  end
end
