require 'active_support/core_ext/module/delegation'

class LogReader
  attr_accessor :log_file

  def initialize
    self.log_file = File.open("/Users/robinboutros/Client.txt", "r")
    move_cursor_to_end_of_file
  end

  def each_valid_line
    log_file.each_line do |log|
      yield(log) if valid_log?(log)
    end
  end

  private

  def valid_log?(log)
    ["RikAndMorty"].any? { |character_name| log.include?("##{character_name}:") }
  end

  def move_cursor_to_end_of_file
    log_file.seek(0, IO::SEEK_END)
  end
end
