require 'parslet'

class Parser::LogParser < Parslet::Parser
  include ::Parser::Rules::Misc
  include ::Parser::Rules::DateAndTime

  rule(:meta_info) { datetime >> number >> space >> hexa >> space >> info_client_id }
  rule(:info_client_id) { str("[INFO Client ") >> number >> str("]") >> space? }
  rule(:debug_client_id) { str("[DEBUG Client ") >> number >> str("]") >> space? }

  rule(:channel?) { (str("#") | str("$")).maybe }
  rule(:user_prompt) { channel? >> match["^:"].repeat(1).as(:character) >> str(":") >> space? }

  rule(:map_name) { (match["a-zA-Z\s"] >> start_options.absent?).repeat(1) }

  # 2 choices:
  # - have the same names as the DB fields here, and then use subtree(:params)
  # in the Transform class
  # - add .maybe everywhere, so that the options always show up, and I can be
  # specific in the Transform class
  rule(:start_options) do
    (str("q") >> space? >> number.as(:item_quantity)) |
    (str("ps") >> space? >> number.as(:pack_size)) |
    (str("t") >> space? >> number.as(:tier)) |
    (str("name") >> space? >> map_name.as(:name))
  end

  rule(:map_start) { str("ms:") >> (space? >> start_options).repeat(0) }

  rule(:map_end) { str("me:") }
  rule(:map_drop) { str("md:") }
  rule(:map_abort) { str("ma:") }
  rule(:map_note) { str("mn:") }
  rule(:map_edit) { str("medit:") }

  rule(:command) do
    map_start.as(:map_start) |
    map_end.as(:map_end) |
    map_drop.as(:map_drop) |
    map_abort.as(:map_abort) |
    map_note.as(:map_note) |
    map_edit.as(:map_edit)
  end

  rule(:chat_log) do
    meta_info >> user_prompt >> space? >> ((command >> anything?) | anything)
  end

  rule(:log) do
    (chat_log | anything) >> eol?
  end

  root(:log)
end
