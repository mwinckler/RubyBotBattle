module Exceptions
  class InsufficientEnergyError < StandardError
    attr_reader :bot
    def initialize(bot, msg = "There is not enough energy to perform that action.")
      super(msg)

      @bot = bot
    end
  end
end