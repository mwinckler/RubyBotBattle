require_relative "./validators/energy"
require_relative "../util/direction"
require_relative "result"

module Actions
  class MovementBase
    # Note: speed can be negative to go backward
    def self.execute(game_state, bot_state, speed)
      raise new ArgumentError("speed must be 1 or -1") unless speed.abs() == 1
      Validators::Energy.validate(1, bot_state)

      destination = calculate_destination(bot_state, speed)

      if !can_advance?(game_state, destination)
        return Actions::Result.new(false)
      end

      bot_state.position = destination
      bot_state.available_energy -= 1

      return Actions::Result.new(true)
    end

    private

    def self.calculate_destination(bot_state, speed)
      offset = Util::Direction.create_offset(bot_state.facing, speed)
      return bot_state.position.translate(offset.x, offset.y)
    end

    def self.can_advance?(game_state, destination)
      return game_state.in_bounds?(destination) &&
        !game_state.occupied?(destination)
    end
  end
end
