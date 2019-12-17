require_relative "validators/energy"
require_relative "result"
require_relative "../util/direction"
require_relative "animations/lunge"

module Actions
  class Lunge
    def self.execute(game_state, bot_state)
      Validators::Energy.validate(5, bot_state)

      success = ->(animations = []) { Actions::Result.new(true, [animations].flatten) }
      bot_state.available_energy -= 5

      lunge_distance = 3
      animations = []

      desired_destination = bot_state.position.translate(Util::Direction.create_offset(bot_state.facing, lunge_distance))
      first_occupied_point = game_state.first_occupied(bot_state.position, bot_state.facing)
      point_before_occupied = first_occupied_point.translate(Util::Direction.create_offset(Util::Direction.opposite(bot_state.facing), 1))

      if (first_occupied_point.x - bot_state.position.x).abs > lunge_distance ||
        (first_occupied_point.y - bot_state.position.y).abs > lunge_distance
        # Destination was unoccupied. Update position and return.
        animations << Actions::Animations::Lunge.new(bot_state.position, desired_destination)
        bot_state.position = desired_destination
        return success.(animations)
      end

      if !game_state.in_bounds?(first_occupied_point)
        # Hit a wall. Move as far as possible and lose 2 health.
        animations << Actions::Animations::Lunge.new(bot_state.position, point_before_occupied)
        bot_state.position = point_before_occupied
        bot_state.health -= 2

        if bot_state.health <= 0
          animations << Actions::Animations::DestroyBot.new(bot_state.position)
        end

        return success.(animations)
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
          animations << Actions::Animations::Lunge.new(bot_state.position, first_occupied_point)
          bot_state.position = first_occupied_point
          enemy_bot.position.translate!(single_tile_offset)
          enemy_bot.health -= 1
        else
          # The space behind is occupied; the victim is caught
          # between a bot and a hard place and suffers an extra damage.
          animations = Actions::Animations::Lunge.new(bot_state.position, point_before_occupied)
          bot_state.position = point_before_occupied
          enemy_bot.health -= 2
        end
      end

      animations = [enemy_bot, bot_state].
        filter{|bot| bot.health <= 0 }.
        map{|dead_bot| Actions::Animations::DestroyBot.new(dead_bot.position) }

      return success.(animations)
    end
  end
end