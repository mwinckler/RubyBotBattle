# A marine-based variant of the venerable D Bot
class CBot
  def initialize()
    @turn = 0
  end

  def display_name()
    return "C Bot"
  end

  def act(game_state, bot_state)
    @turn += 1
    return :charge_battery if bot_state.available_energy < 5
    return "face_#{["north", "east", "south", "west"].sample}".to_sym() if @turn % 4 == 0
    return :fire_laser
  end
end