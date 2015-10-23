# require 'tk'
require "active_support"
require 'figleaf'
require 'clipboard'
require 'require_all'
require "base64"

require_rel '../config/initializers'
require_rel '../lib'

class Pompom
  attr_accessor :gui, :log_reader, :log_parser

  LOOP_DELAY = 1000

  def initialize
    # self.gui = Gui.new
    self.log_reader = LogReader.new
    self.log_parser = Parser::LogParser.new
  end

  def start
    schedule_read_logs
    # Tk.mainloop
  end

  private

  def schedule_read_logs
    sleep(LOOP_DELAY / 1000)
    read_logs
    # gui.after(loop_delay) { read_logs }
  end

  def read_logs
    puts "debug: READING logs..."

    log_reader.each_valid_line { |log| parse_log(log) }

    schedule_read_logs
  end

  def parse_log(log)
    puts "debug: PARSING logs... #{log}"

    parsed_logs = log_parser.parse(log)
    puts "parsed: #{parsed_logs}"
    map = map(parsed_logs)

    # todo: test what happens with logs that cant be parsed
    API.log(
      log: parsed_logs,
      map: (Base64.encode64(map) if map.present?)
    )
  end

  def map(log)
    return "" unless send_map?(log)

    cp_content = Clipboard.paste # Get map from clipboard
    puts cp_content

    return "" unless cp_content.include? "Travel to this Map"
    cp_content
  end

  def send_map?(log)
    return false unless log[:command]
    !!log[:command][:map_start]
  end

  def loop_delay
    LOOP_DELAY
  end
end

pompom = Pompom.new
pompom.start

