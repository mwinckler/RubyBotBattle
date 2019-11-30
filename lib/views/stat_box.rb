require "tty-cursor"
require "pastel"

module Views
  class StatBox
    def initialize(location, bot_colors)
      @location = location
      @bot_colors = bot_colors
      @cursor = TTY::Cursor
      @pastel = Pastel.new
      @width = 20
      @stat_rows = 3
    end

    def render(frame, game_state, bot_states)
      clear()

      bot_states.each_with_index do |state, row|
        move = ->(offset) { @cursor.move_to(@location.x, @location.y + row * @stat_rows + offset) }
        write_name = ->(name) { @pastel.on_black(state.alive?() ? @bot_colors[state.bot.display_name()].(name) : @pastel.bright_black(name)) }
        print move.(0)
        print write_name.(state.bot.display_name())
        print move.(1)
        print @pastel.on_black("E: #{state.available_energy} H: #{state.health}")
      end

      print @cursor.move_to(@location.x, @location.y + bot_states.count * @stat_rows + 2)
      print @pastel.on_black("Turn: #{game_state.turn}   Frame: #{frame}")

    end

    def clear()
      (0..@bot_colors.count * @stat_rows).each do |row|
        print @cursor.move_to(@location.x, @location.y + row)
        print " " * @width
      end
    end
  end
end