require_relative "../constants"
require_relative "validators/energy"
require_relative "animations/destroy_bot"
require_relative "animations/fire_laser"
require_relative "result"

module Actions
  class FireLaser
    def self.execute(game_state, bot_state)
      Validators::Energy.validate(5, bot_state)

      bot_state.available_energy -= 5
      hit_point = game_state.first_occupied(bot_state.position, bot_state.facing)
      animations = [Actions::Animations::FireLaser.new(bot_state.position, hit_point)]
      damaged_bot = game_state.bot_at(hit_point)

      if !damaged_bot.nil?
        damaged_bot.health -= Constants::LASER_DAMAGE
      end

      return Actions::Result.new(true, animations)
    end
  end
end