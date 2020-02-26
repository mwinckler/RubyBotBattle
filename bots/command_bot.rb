# A bot you can control!
# -----IMPORTANT BEFORE USAGE!-------
# controls --
# w is face north, a is face west, s is face south, d is face east.
# q will return advance, while f is fire laser.
# pressing l results in lunge, r is repair, c is charge. b is reverse.
class CommandBot
  def initialize()
    @turn = 0
  end

  def display_name()
    return "Command Bot"
  end

  def act(game_state, bot_state)
    @turn += 1
    prompt = TTY::Prompt.new()
    key = prompt.keypress("", timeout: 1)
    if key == 'w'
     return :face_north
    end

    if key == 'a'
      return :face_west
    end

    if key == 's'
      return :face_south
    end

    if key == 'd'
      return :face_east
    end

    if key == 'q'
      return :advance
    end

    if key == 'f'
      return :fire_laser
    end

    if key == 'l'
      return :lunge
    end

    if key == 'r'
      return :repair
    end

    if key == 'c'
      return :charge_battery
    end

    if key == 'b'
      return :reverse
    end
  end
  return :charge_battery
end
