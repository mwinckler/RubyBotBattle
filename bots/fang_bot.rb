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
    

    class See
        def self.execute(direction, bot_state)
            opponent = c_bot
            opponent2 = d_bot
            
            Validators::opponent.validate(opponent)
            Validators::Energy.validate(1, bot_state) 
            bot_state.available_energy -= 1
            bot_state.facing = opponent
            return Actions::Result.new(true)
        end
    end    
    def act(game_state, bot_state)
        @turn += 1
        if 
            return :fire_laser
        end
    end
    
    if bot_state.position.x == 0 && bot_state.facing == :north && !face opponent
        return :face_south
    end
    if bot_state.position.y == 0 && bot_state.facing == :south && !face opponent
        return :face_west
    end
    if bot_state.position.x == game_state.arena_size.width - 1 && bot_state.facing == :west && !face opponent
        return :face_east
    end
    if bot_state.position.y == game_state.arena_size.height - 1 && bot_state.facing == :east && !face opponent
        return :face_north
    end
end


# Implement display name, act method, and hunts down enemy  attr_accessor :arena_size, :bot states, :turn
