class Puddle2Bot
  def initialize()
    @turn = 0
  end

  def display_name()
    return "Puddle Bot 2"
  end

  def act(game_state, bot_state)
    @turn += 1
    prompt = TTY::Prompt.new

    prompt.on(:keyescape) { |key| Q [] }
    return :advance

    prompt.on(:keyescape) { |key| W [] }
    return :face_north

    prompt.on(:keyescape) { |key| A [] }
    return :face_east

    prompt.on(:keyescape) { |key| S [] }
    return :face_south

    prompt.on(:keyescape) { |key| D [] }
    return :face_west

    prompt.on(:keyescape) { |key| L [] }
    return :lunge

    prompt.on(:keyescape) { |key| F [] }
    return :fire_laser

    prompt.on(:keyescape) { |key| C [] }
    return :charge_battery

    prompt.on(:keyescape) { |key| R [] }
    return :repair

    prompt.on(:keyescape) { |key| K [] }
    return :reverse
  end
end
