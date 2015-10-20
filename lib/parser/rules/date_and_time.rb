require 'active_support/concern'

module Parser::Rules::DateAndTime
  extend ActiveSupport::Concern

  included do
    rule(:day)   { match['0123'] >> digit }
    rule(:month) { match['01'] >> digit }
    rule(:year)  { digit.repeat(4, 4) }
    rule(:date)  { year >> slash >> month >> slash >> day }

    rule(:hour)    { match['012'] >> digit } # close enough
    rule(:minutes) { match['0123456'] >> digit }
    rule(:seconds) { minutes }
    rule(:timestamp)    { hour >> str(":") >> minutes >> str(":") >> seconds }

    rule(:datetime) { date >> space >> timestamp >> space? }
end
end
