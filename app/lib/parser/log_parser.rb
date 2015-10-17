require 'parslet'

class Parser::LogParser < Parslet::Parser
  include ::Parser::Rules::Misc
  include ::Parser::Rules::DateAndTime

  rule(:meta_info) { datetime >> number >> space >> hexa >> space >> info_client_id }
  rule(:info_client_id) { str("[INFO Client ") >> number >> str("]") >> space? }
  rule(:debug_client_id) { str("[DEBUG Client ") >> number >> str("]") >> space? }

  rule(:channel) { str("#") | str("$") }
  rule(:user_prompt) { channel >> match["^:"].repeat(1).as(:username) >> str(":") >> space? }

  rule(:map_start) { str("ms:") }

  rule(:map_end) { str("me:") }

  rule(:command) do
    map_start |
    map_end
  end

  rule(:chat_log) do
    meta_info >> user_prompt >> (command | anything)
  end

  rule(:log) do
    chat_log | anything
  end

  root(:log)
end
