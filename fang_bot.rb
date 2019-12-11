# This is a Work in Progress.
# there is one problem I am stll addressing.
# When it is done, it will turn around and around until
# it sees an enemy bot. When it does, it will shoot until
# the enemy bot goes out of its line of fire. 

class FangBot
  def initialize()
    @turn = 0
  end
  
  def display_name()
    return "FangBot"
  end
  
  opponent = 
  class See
    def self.execute(direction, bot_state)
      Validators::opponent.validate(opponent)
      Validators::Energy.validate(1, bot_state)

      bot_state.available_energy -= 1
      bot_state.facing = opponent
      return Actions::Result.new(true)
    end
  end
  
  # def act(game_state, bot_state)
  # @turn += 1
  # return :charge_battery if bot_state.available_energy < 5
  # return "face_#{["north", "east", "south", "west"].sample}".to_sym() if @turn % 4 == 0
  # return :fire_laser
  
  
  
  
  def act(game_state, bot_state)
    @turn += 1
    if 'FangBot' face 'opponent'
      return :fire_laser
    end
end

if bot_state.position.x == 0 && bot_state.facing == :north && !face opponent
  return :face_south
elsif bot_state.position.y == 0 && bot_state.facing == :south && !face opponent
  return :face_west
elsif bot_state.position.x == game_state.arena_size.width - 1 && bot_state.facing == :west && !face opponent
  return :face_east
elsif bot_state.position.y == game_state.arena_size.height - 1 && bot_state.facing == :east && !face opponent
  return :face_north
end

    
    # Implement display name, act method, and hunts down enemy  attr_accessor :arena_size, :bot states, :turn
    
