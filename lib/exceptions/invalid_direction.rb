module Exceptions
  class InvalidDirectionError < StandardError
    def initialize(direction, msg = "That is not a valid direction: #{direction}.")
      if !direction.is_a?(Symbol)
        msg += " (Do you need to convert it to a symbol?)"
      end

      super(msg)
    end
  end
end