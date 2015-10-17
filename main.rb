require 'tk'
require 'require_all'

require_rel 'gui'
require_rel 'app/lib'

class Pompom
  attr_accessor :gui, :log_reader, :log_parser

  LOOP_DELAY = 1000

  def initialize
    self.gui = Gui.new
    self.log_reader = LogReader.new
    self.log_parser = Parser::LogParser.new

    puts parse_log("2010/15 09:10:33 2977154 287 [INFO Client 2168] $hsdis: WTB Orb of Alchemy , paying _ 1 : 2.5")
    puts parse_log("2015/10/15 09:10:33 2977154 287 [INFO Client 2168] $hsdis: WTB Orb of Alchemy , paying _ 1 : 2.5")
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
    puts "debug: reading logs..."

    log_reader.each_valid_line { |log| parse_log(log) }

    schedule_read_logs
  end

  def parse_log(log)
    puts "debug: reading logs..."
    log_parser.parse(log)
  end

  def loop_delay
    LOOP_DELAY
  end
end

pompom = Pompom.new
# pompom.start

