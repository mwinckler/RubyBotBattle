require_relative "result"

module Actions
  class ChargeBattery
    def self.execute(bot_state)
      bot_state.available_energy += 5
      return Actions::Result.new(true)
    end
  end
end