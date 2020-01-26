#Fools rush in.
#  This bot isn't subtle - move into position and laser enemies without further ado.
#  OK for dumb bots that don't happen to be shooting in its direction.
#  Not so great for fancy-dancy sneaky bots.
class HunterKiller
  @move_count

  def initialize()
    @move_count = 0
  end

  def display_name()
    return "Hunter Killer"
  end

  def act(game_state, bot_state)

    if bot_state.available_energy < 5
      return :charge_battery
    end
 
# Identify closest enemy

closest_enemy=game_state.enemies[0]

    mindist = 999
    game_state.enemies.each do |each_enemy|
      x_dist = bot_state.position.x-each_enemy.position.x
      y_dist = bot_state.position.y-each_enemy.position.y
      dist = [x_dist.abs,y_dist.abs].min
      if dist < mindist
        closest_enemy = each_enemy
        mindist = dist
      end
    end


    x_dist = bot_state.position.x-closest_enemy.position.x
    y_dist = bot_state.position.y-closest_enemy.position.y

    if x_dist == 0
      if y_dist < 0
        if bot_state.facing == :south
          return :fire_laser
        else
          return :face_south
        end
      else
        if bot_state.facing == :north
          return :fire_laser
        else
          return :face_north
        end
      end
    end

    if y_dist == 0
      if x_dist < 0
        if bot_state.facing == :east
          return :fire_laser
        else
          return :face_east
        end
      else
        if bot_state.facing == :west
          return :fire_laser
        else
          return :face_west
        end
      end
    end

    if x_dist.abs <= y_dist.abs
      if x_dist < 0
        if bot_state.facing == :east
          return :advance
        else
          return :face_east
        end
      else
        if bot_state.facing == :west
          return :advance
        else
          return :face_west #This used to say "wast" but I, Henry, fixed it.
        end
      end
    else
      if y_dist < 0
        if bot_state.facing == :south
          return :advance
        else
          return :face_south
        end
      else
        if bot_state.facing == :north
          return :advance
        else
          return :face_north
        end
      end
    end

  end # def act
end  # class HunterKiller