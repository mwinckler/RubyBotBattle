# A sentry cannon type bot
class TheBurninator 
  def initialize()
    @turn = 0
  end 

  def display_name()
    return "The Burninator!"
  end

  def act(game_state, bot_state)
    @turn += 1

    y_state = game_state.enemies[0].position.y 
    x_state = game_state.enemies[0].position.x

    my_ystate = bot_state.position.y 
    my_xstate = bot_state.position.x

    y_dif = my_ystate - y_state
    x_dif = my_xstate - x_state


    if bot_state.health < 5
      return :repair 
    end

    if x_dif == 0
      if y_dif > 0
        if bot_state.facing == :north
          if y_dif.abs <= 3
            return :lunge
          else
            return :fire_laser
          end
        else
          return :face_north
        end
      else
        if bot_state.facing == :south
          if y_dif.abs <= 3
            return :lunge
          else
            return :fire_laser
          end
        else
          return :face_south
        end
      end
    end

    if y_dif == 0
      if x_dif < 0 
        if bot_state.facing == :east
          if x_dif.abs <= 3 
            if game_state.enemies[0].health == 1
              return :lunge
            else
              return :fire_laser
            end
          else
            return :fire_laser
          end
        else
          return :face_east
        end
      else
        if bot_state.facing == :west
          if x_dif.abs <= 3
            if game_state.enemies[0].health == 1
              return :lunge
            else
              return :fire_laser
            end
          else
            return :fire_laser
          end
        else 
          return :face_west
        end
      end
    end      
    
    if @turn > 1 
      if y_dif.abs <= 3
        if  x_dif.abs <= 3 
          return :reverse
        end
      end
    end 

    if @turn > 60  # hunter mode
      if y_dif.abs > x_dif.abs   #  closer in x direction
        if x_dif < 0  # enemy is to east
            if bot_state.facing == :east
              if x_dif.abs >= 3
                return :lunge
              else
                return :advance
              end
            elsif bot_state.facing == :west
              return :reverse
            else
              return :face_east
            end
        else # enemy is west
            if bot_state.facing == :west
              if x_dif.abs >= 3
                return :lunge
              else
                return :advance
              end
            elsif bot_state.facing == :east
              return :reverse
            else
              return :face_west
            end
        end
      else
          if y_dif < 0 # enemy is south
              if bot_state.facing == :south
                if x_dif.abs >= 3
                  return :lunge
                else
                  return :advance
                end
              elsif bot_state.facing == :north
                return :reverse
              else
                return :face_south
              end
          else # enemy is north
              if bot_state.facing == :north
                if x_dif.abs >= 3
                  return :lunge
                else
                  return :advance
                end
              elsif bot_state.facing == :south
                return :reverse
              else
                return :face_north
              end
          end
      end     
    else  # cannon mode
      if y_dif.abs > x_dif.abs
        if y_dif > 0
          if bot_state.facing != :north  
            return :face_north
          elsif x_dif == 0
            return :fire_laser
          else 
            return :charge_battery
          end
        else 
          if bot_state.facing != :south 
            return :face_south
          elsif x_dif == 0
            return :fire_laser
          else
            return :charge_battery
          end
        end
      else
        if x_dif > 0  
          if bot_state.facing != :west
            return :face_west
          elsif y_dif == 0
            return :fire_laser
          else
            return :charge_battery
          end
        else 
          if bot_state.facing != :east
            return :face_east 
          elsif y_dif == 0
            return :fire_laser
          else
            return :charge_battery
          end
        end
      end
    end
  end
end


