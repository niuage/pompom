require 'active_support/core_ext/module/delegation'

class Gui
  attr_accessor :root

  delegate :after, to: :root

  def initialize
    self.root = TkRoot.new { title "Hello, World!" }
    setup_gui
  end

  private

  def setup_gui
    TkLabel.new(root) do
      text 'Hello, World!'
      pack { padx 15 ; pady 15; side 'left' }
    end
  end
end
