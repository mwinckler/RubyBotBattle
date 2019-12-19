module Exceptions
  class InvalidConditionError < StandardError
    def initialize(condition, msg = "That is not a valid condition: #{direction}.")
      if !condition.is_a?(Symbol)
        msg += " (Do you need to convert it to a symbol?)"
      end

      super(msg)
    end
  end
end