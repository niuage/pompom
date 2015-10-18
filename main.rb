require 'tk'
require "active_support"
require 'figleaf'
require 'require_all'

require_rel 'app/lib'
require_rel 'gui'
require_rel 'api'

class Pompom
  attr_accessor :gui, :log_reader, :log_parser

  LOOP_DELAY = 1000

  def initialize
    self.gui = Gui.new
    self.log_reader = LogReader.new
    self.log_parser = Parser::LogParser.new
  end

  def start
    schedule_read_logs
    Tk.mainloop
  end

  private

  def schedule_read_logs
    gui.after(loop_delay) { read_logs }
  end

  def read_logs
    puts "debug: READING logs..."

    log_reader.each_valid_line { |log| parse_log(log) }

    schedule_read_logs
  end

  def parse_log(log)
    puts "debug: PARSING logs... #{log}"

    API.logs log_parser.parse(log)
  end

  def loop_delay
    LOOP_DELAY
  end
end

pompom = Pompom.new
pompom.start

