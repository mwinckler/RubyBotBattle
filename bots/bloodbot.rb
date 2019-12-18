class Bloodbot
    def initialize()
    end
    
    def display_name()
        return "Bloodbot"
    end
    
    
    def act(game_state, bot_state)
        
        # Right now, this program only works with one bot.
        # I need to fix that.
        number_of_enemies = game_state.enemies.count
        puts "#{number_of_enemies}"
        @enemy = game_state.enemies.first
        
        # Hopefully this will work.
        # It redefines the enemy variable when the targeted enemy is dead
        if game_state.enemies.first.health < 0 && number_of_enemies > 1
            @enemy = game_state.enemies.second
            if game_state.enemies.second.health < 0 && number_of_enemies > 2 
                @enemy = game_state.enemies.third
                if game_state.enemies.third.health < 0 && number_of_enemies > 3
                    @enemy = game_state.enemies.fourth
                end
            end
        end
    
        # Recharge battery if needed
        if bot_state.available_energy < 5
            return :charge_battery
        end
    
        # Check if I am walking into line of fire
        if bot_state.position.x - 1 == @enemy.position.x && bot_state.position.y < @enemy.position.y && @enemy.facing == :north && 
            @enemy.available_energy >= 5 && bot_state.facing != :south
            return :reverse
        end
        if bot_state.position.x + 1 == @enemy.position.x && bot_state.position.y < @enemy.position.y && @enemy.facing == :north && 
            @enemy.available_energy >= 5 && bot_state.facing != :south
            return :reverse
        end
        if bot_state.position.x - 1 == @enemy.position.x && bot_state.position.y > @enemy.position.y && @enemy.facing == :south && 
            @enemy.available_energy >= 5 && bot_state.facing != :north
            return :reverse
        end
        if bot_state.position.x + 1 == @enemy.position.x && bot_state.position.y > @enemy.position.y && @enemy.facing == :south && 
            @enemy.available_energy >= 5 && bot_state.facing != :north
            return :reverse
        end
        if bot_state.position.y - 1 == @enemy.position.y && bot_state.position.x < @enemy.position.x && @enemy.facing == :west && 
            @enemy.available_energy >= 5 && bot_state.facing != :east
            return :reverse
        end
        if bot_state.position.y + 1 == @enemy.position.y && bot_state.position.x < @enemy.position.x && @enemy.facing == :west && 
            @enemy.available_energy >= 5 && bot_state.facing != :east
            return :reverse
        end
        if bot_state.position.y - 1 == @enemy.position.y && bot_state.position.x > @enemy.position.x && @enemy.facing == :east && 
            @enemy.available_energy >= 5 && bot_state.facing != :west
            return :reverse
        end
        if bot_state.position.y + 1 == @enemy.position.y && bot_state.position.x > @enemy.position.x && @enemy.facing == :east && 
            @enemy.available_energy >= 5 && bot_state.facing != :west
            return :reverse
        end
        
        # Check if I can shoot the enemy and shoot if possible
        if bot_state.position.x == @enemy.position.x && bot_state.position.y < @enemy.position.y && bot_state.facing == :south && bot_state.available_energy >= 5
            return :fire_laser
        end
        if bot_state.position.x == @enemy.position.x && bot_state.position.y > @enemy.position.y && bot_state.facing == :north && bot_state.available_energy >= 5
            return :fire_laser
        end
        if bot_state.position.y == @enemy.position.y && bot_state.position.x < @enemy.position.x && bot_state.facing == :east && bot_state.available_energy >= 5
            return :fire_laser
        end
        if bot_state.position.y == @enemy.position.y && bot_state.position.x > @enemy.position.x && bot_state.facing == :west && bot_state.available_energy >= 5
            return :fire_laser
        end
        
        # Seek the enemy
        if @enemy.position.x < bot_state.position.x && bot_state.facing != :west
            return :face_west
        elsif @enemy.position.x < bot_state.position.x && bot_state.facing == :west
            return :advance
        end
        if @enemy.position.y > bot_state.position.y && bot_state.facing != :south
            return :face_south
        elsif @enemy.position.y > bot_state.position.y && bot_state.facing == :south
            return :advance
        end
        if @enemy.position.x > bot_state.position.x && bot_state.facing != :east
            return :face_east
        elsif @enemy.position.x > bot_state.position.x && bot_state.facing == :east
            return :advance
        end
        if @enemy.position.y < bot_state.position.y && bot_state.facing != :north
            return :face_north
        elsif @enemy.position.y < bot_state.position.y && bot_state.facing == :north
            return :advance
        end
        
    end
    
end