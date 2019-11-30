module Exceptions
  class InvalidActionError < StandardError
    def initialize(action_name)
      super("Invalid action name: #{action_name}")
    end
  end
end
