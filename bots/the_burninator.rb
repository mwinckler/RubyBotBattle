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

    if @turn > 1 
      if my_ystate.abs 
        if  my_xstate.abs == 1 
          return :reverse
        end
      end
    end 

    y_dif = my_ystate - y_state
    x_dif = my_xstate - x_state

    if x_dif == 0
      if y_dif > 0
        if bot_state.facing == :north
          return :fire_laser
        else
          return :face_north
        end
      else
        if bot_state.facing == :south
          return :fire_laser
        else
          return :face_south
        end
      end
    end

    if y_dif == 0
      if x_dif < 0 
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

    if @turn > 40  # hunter mode
      if y_dif.abs > x_dif.abs   #  closer in x direction
        if x_dif < 0  # enemy is to east
            if bot_state.facing == :east
              return :advance
            else
              return :face_east
            end
        else
            if bot_state.facing == :west
              return :advance
            else
              return :face_west
            end
        end
      else
          if y_dif < 0 #
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


