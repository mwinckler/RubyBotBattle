# A very basic fighting machine inspired by an inexpensive automated vacuum cleaner.
class DBot
  @move_count

  def initialize()
    @move_count = 0
  end

  def display_name()
    return "D Bot"
  end

  def act(game_state, bot_state)
    if bot_state.available_energy < 5
      return :charge_battery
    end

    if bot_state.position.x == 0 && bot_state.facing == :west
      return :face_east
    elsif bot_state.position.y == 0 && bot_state.facing == :north
      return :face_south
    elsif bot_state.position.x == game_state.arena_size.width - 1 && bot_state.facing == :east
      return :face_west
    elsif bot_state.position.y == game_state.arena_size.height - 1 && bot_state.facing == :south
      return :face_north
    end

    directions = ['north', 'east', 'south', 'west']
    @move_count += 1

    if rand(0..20) < @move_count
      @move_count = 0
      return "face_#{directions[rand(0..3)]}"
    end

    if rand(0..100) > 80
      return :advance 
    end

    return :fire_laser
  end
end