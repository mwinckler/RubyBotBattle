class Kablamo

  def initialize()
  end

  def display_name()
    return "Kablamo"
  end

  def act(game_state, bot_state)

    bot_x = bot_state.position.x
    bot_y = bot_state.position.y

    enemy_x = game_state.enemies[0].position.x
    enemy_y = game_state.enemies[0].position.y

    # charge battery
    if bot_state.available_energy < 5
       return :charge_battery
    end

    # Doge the lasers
    if game_state.enemies[0].available_energy < 5
      if bot_x - 1 == enemy_x || bot_x + 1 == enemy_x
        if bot_y < enemy_y
          if game_state.enemies[0].facing == :north
            if bot_x > 3 && bot_x < game_state.arena_size.width - 4 && bot_y > 3 && game_state.arena_size.height - 4
              return :lunge
            else
              return :reverse
            end
          end
        else
          if bot_y > enemy_y
            if game_state.enemies[0].facing == :south
              if bot_x > 3 && bot_x < game_state.arena_size.width - 4 && bot_y > 3 && game_state.arena_size.height - 4
                return :lunge
              else
                return :reverse
              end
            end
          end
        end
      else
        if bot_y - 1 == enemy_y || bot_y + 1 == enemy_y
          if bot_x < enemy_x
            if game_state.enemies[0].facing == :west
              if bot_x > 3 && bot_x < game_state.arena_size.width - 4 && bot_y > 3 && game_state.arena_size.height - 4
                return :lunge
              else
                return :reverse
              end
            end
          else
            if bot_x > enemy_x
              if game_state.enemies[0].facing == :east
                if bot_x > 3 && bot_x < game_state.arena_size.width - 4 && bot_y > 3 && game_state.arena_size.height - 4
                  return :lunge
                else
                  return :reverse
                end
              end
            end
          end
        end
      end
    end

   # Track enemy on the x axis
    if bot_x < enemy_x && bot_state.facing != :east
      return :face_east
    elsif bot_x > enemy_x && bot_state.facing != :west
      return :face_west
    end

    # Attack if enemy is already at the same y as me
    if bot_y == enemy_y
        return :fire_laser
    end

    # Advance if otherwise
    if bot_x != enemy_x
      return :advance
    end

    # Track and attack enemy on the y axis
    if bot_y < enemy_y && bot_state.facing != :south
      return :face_south
    elsif bot_y > enemy_y && bot_state.facing != :north
      return :face_north
    else
      return :fire_laser
    end

  end
end