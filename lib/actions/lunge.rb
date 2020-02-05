require_relative "validators/energy"
require_relative "result"
require_relative "../util/direction"

module Actions
  class Lunge
    def self.execute(animation_manager, game_state, bot_state)
      Validators::Energy.validate(5, bot_state)

      bot_state.available_energy -= 5

      lunge_distance = 3

      desired_destination = bot_state.position.translate(Util::Direction.create_offset(bot_state.facing, lunge_distance))
      first_occupied_point = game_state.first_occupied(bot_state.position, bot_state.facing)
      point_before_occupied = first_occupied_point.translate(Util::Direction.create_offset(Util::Direction.opposite(bot_state.facing), 1))

      if (first_occupied_point.x - bot_state.position.x).abs > lunge_distance ||
        (first_occupied_point.y - bot_state.position.y).abs > lunge_distance
        # Destination was unoccupied. Update position and return.
        animation_manager.add_lunge(bot_state.position, desired_destination)
        bot_state.position = desired_destination

        return
      end

      if !game_state.in_bounds?(first_occupied_point)
        # Hit a wall. Move as far as possible and lose 2 health.
        animation_manager.add_lunge(bot_state.position, point_before_occupied)
        bot_state.position = point_before_occupied
        bot_state.health -= 2

        return
      end

      # Arriving here, something was in the way. Take a damage.
      bot_state.health -= 1

      # Is it a bot?
      enemy_bot = game_state.bot_at(first_occupied_point)
      if !enemy_bot.nil?
        # Is there an empty space behind the enemy?
        single_tile_offset = Util::Direction.create_offset(bot_state.facing, 1)
        target_point = first_occupied_point.translate(single_tile_offset)
        if !game_state.occupied?(target_point) && game_state.in_bounds?(target_point)
          # Then both bots bump along and suffer a damage.
          animation_manager.add_lunge(bot_state.position, first_occupied_point)
          bot_state.position = first_occupied_point
          enemy_bot.position.translate!(single_tile_offset)
          enemy_bot.health -= 1
        else
          # The space behind is occupied; the victim is caught
          # between a bot and a hard place and suffers an extra damage.
          animation_manager.add_lunge(bot_state.position, point_before_occupied)
          bot_state.position = point_before_occupied
          enemy_bot.health -= 2
        end
      end
    end
  end
end