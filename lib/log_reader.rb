class LogReader
  attr_accessor :log_file

  delegate :characters, :log_file, to: :Settings, prefix: "settings"

  def initialize
    self.log_file = File.open(settings_log_file.path, "r")
    # move_to_end_of_file
  end

  def each_valid_line
    log_file.each_line do |log|
      yield(log) if valid_log?(log)
    end
  end

  private

  def valid_log?(log)
    settings_characters.any? { |character_name| log =~ /(#|\$)?#{character_name}:/ }
  end

  def move_to_end_of_file
    log_file.seek(0, IO::SEEK_END)
  end
end
