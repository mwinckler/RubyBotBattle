require_relative "validators/energy"
require_relative "result"
require_relative "../constants"
require_relative "animations/repair"

module Actions
  class Repair
    def self.execute(bot_state)
      Validators::Energy.validate(20, bot_state)

      bot_state.available_energy -= 20
      bot_state.health = [Constants::STARTING_HEALTH, bot_state.health + 3].min
      return Result.new(true, [Actions::Animations::Repair.new(bot_state.position)])
    end
  end
end
