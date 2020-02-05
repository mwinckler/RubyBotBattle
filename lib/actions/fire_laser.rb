require_relative "../constants"
require_relative "validators/energy"
require_relative "result"

module Actions
  class FireLaser
    def self.execute(animation_manager, game_state, bot_state)
      Validators::Energy.validate(5, bot_state)

      bot_state.available_energy -= 5
      hit_point = game_state.first_occupied(bot_state.position, bot_state.facing)
      animation_manager.add_fire_laser(bot_state.position, hit_point)
      damaged_bot = game_state.bot_at(hit_point)

      if !damaged_bot.nil?
        damaged_bot.health -= Constants::LASER_DAMAGE
      end
    end
  end
end