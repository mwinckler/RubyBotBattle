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

   # Track or shoot enemy on the X axis
    if bot_x < enemy_x && bot_state.facing != :east
      return :face_east
    elsif bot_x > enemy_x && bot_state.facing != :west
      return :face_west
    elsif bot_y == enemy_y
        return :fire_laser
    elsif bot_x != enemy_x
      return :advance
    end
    
    # Attack enemy on the Y axis
    if bot_y < enemy_y && bot_state.facing != :south
      return :face_south
    elsif bot_y > enemy_y && bot_state.facing != :north
      return :face_north
    else
      return :fire_laser
    end
 
  end 
end 