# This is a puddle.
# It is sentient.
# Beware the puddle.
class PuddleBot
    def initialize()
        @turn = 0
    end

    def display_name()
        return "The Puddle Bot"
    end

    def act(game_state, bot_state)
        @turn += 1
        # The enemy x and y position
        enemy_x = game_state.enemies[0].position.x
        enemy_y = game_state.enemies[0].position.y
        # The puddle x and y
        puddle_x = bot_state.position.x
        puddle_y = bot_state.position.y
        # Difference between 2 positions
        x_diff = puddle_x - enemy_x
        y_diff = puddle_y - enemy_y
        # This is where the code gets real.
        # abs = absolute value according to ruby.docs so that will account for negative+positive quadrants...
        # This should put the puddle into a mode where he will wait 19 turns just to see if a bot will come into LoS
        # Kind of like Henry's but shorter so that the puddle will strike first...
        # It should work.

        puts "Charging..."
        # Shoot if bot is in LoS x line
        if x_diff == 0
            if y_diff > 0
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
        # Shoot if bot is in LoS y line
        if y_diff == 0
            if x_diff < 0
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
        # Mobile Puddle 3000 Tech
        # REMEMBER THAT abs = ABSOLUTE VALUE! (rubydocs)
        # mobility for the puddle in the x-axis
        if @turn > 20
            puts "The Puddle Has Now Become Mobile."
            if y_diff.abs > x_diff.abs
                if x_diff < 0
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
                # same stuff, except for the y-axis
                if y_diff < 0
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

            # a shooting puddle?!
            # remember, abs is the absolute value...
            # for the y
        else
            if y_diff.abs > x_diff.abs
                if y_diff > 0
                    if bot_state.facing != :east
                        return :face_east
                    elsif y_diff == 0
                        return :fire_laser
                    else
                        return :charge_battery
                    end
                else
                    if bot_state.facing != :face_west
                        return :face_west
                    elsif y_diff == 0
                        return :fire_laser
                    else
                        return :charge_battery
                    end
                end
                # and the x!
            else
                if x_diff > 0
                    if bot_state.facing != :north
                        return :face_north
                    elsif x_diff == 0
                        return :fire_laser
                    else
                        return :charge_battery
                    end
                else
                    if bot_state.facing != :south
                        return :face_south
                    elsif x_diff == 0
                        return :fire_laser
                    else
                        return :charge_battery
                    end
                end
            end
        end
    end
end
# IT WORKS!!!!
# ...
# LONG HAVE I BEEN IN THE MAKING
# IT IS NOW TIME TO COME FORTH
# AND DESTROY BOTS!!!!
# I AM PUDDLE BOT AND I AM HERE TO ANNIHALATE
# MADE BY THE MASTER OF DUBIOUS CODING
# I HAVE STAYED LOW THIS LONG
# BUT NOW I AM READY
# TO DESTROY!!!!
# "Theres is not to reason why/theres is but to do and [sic]"
# -- Tennyson, Lord Alfred
# @Trogdor Burninator Bot:
# Hello.
# My name is Puddle Bot.
# You killed other bots.
# Prepare to Die.