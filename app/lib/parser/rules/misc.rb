require 'active_support/concern'

module Parser::Rules::Misc
  extend ActiveSupport::Concern

  included do
    rule(:cr)       { str("\n") }
    rule(:eof?)     { any.absent? }
    rule(:eol?)     { cr | eof? }
    rule(:space)    { match['\s\t'].repeat(1) }
    rule(:space?)   { space.maybe }
    rule(:slash)    { str("/") }
    rule(:digit)    { match('\\d') }
    rule(:number)   { digit.repeat }
    rule(:hexa) { match["0-9a-fA-F"].repeat }
    rule(:anything) { match("[^\n]").repeat(1) }
  end
end
