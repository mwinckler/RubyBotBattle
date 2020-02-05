require_relative "validators/energy"
require_relative "result"
require_relative "../constants"

module Actions
  class Repair
    def self.execute(animation_manager, bot_state)
      Validators::Energy.validate(20, bot_state)

      bot_state.available_energy -= 20
      bot_state.health = [Constants::STARTING_HEALTH, bot_state.health + 3].min
      animation_manager.add_repair(bot_state.position)
    end
  end
end
