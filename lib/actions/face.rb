require_relative "validators/direction"
require_relative "validators/energy"
require_relative "result"

module Actions
  class Face
    def self.execute(direction, bot_state)
      Validators::Direction.validate(direction)
      Validators::Energy.validate(1, bot_state)

      bot_state.available_energy -= 1
      bot_state.facing = direction
      return Actions::Result.new(true)
    end
  end
end