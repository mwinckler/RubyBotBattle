require "pastel"
require "tty-box"
require "tty-cursor"
require_relative "../constants"
require_relative "stat_box"
require_relative "../models/point"

module Views
  class Arena
    @@facing_indicators = {
      north: "^",
      east: ">",
      south: "v",
      west: "<"
    }

    attr_accessor :render_offset

    def initialize(width, height, bots)
      @width = width
      @height = height
      @pastel = Pastel.new()

      available_colors = [@pastel.red.detach, @pastel.green.detach, @pastel.cyan.detach, @pastel.yellow.detach, @pastel.white.detach, @pastel.magenta.detach]
      @bot_colors = bots.to_h {|bot| [bot.display_name, available_colors.shift()]}

      print TTY::Box.frame(
        width: width + 2,
        height: height + 2,
        style: {
          bg: :black,
          border: {
            bg: :black
          }
        },
        title: {
          top_center: 'BOT BATTLE ARENA'
        }
      )

      @child_views = [
        Views::StatBox.new(Models::Point.new(@width + 3, 1), @bot_colors)
      ]

      # Account for the width of the arena frame so
      # animations can translate game board coordinates
      # to screen coordinates
      @render_offset = Models::Point.new(1, 1)
    end

    def render(game_state, bot_states, frame)
      clear_arena()

      cursor = TTY::Cursor
      bot_states.each do |state|
        next unless state.alive?()

        print cursor.move_to(state.position.x + 1, state.position.y + 1)

        if should_print_facing?(frame)
          print @pastel.on_black(@@facing_indicators[state.facing])
        else
          print @pastel.on_black(@bot_colors[state.bot.display_name].call('X'))
        end
      end

      @child_views.each { |view| view.render(frame, game_state, bot_states) }
    end

    def reset_cursor()
      print TTY::Cursor.move_to(0, @height + 2)
    end

    private

    def clear_arena()
      (1..@height).each do |y|
        print TTY::Cursor.move_to(1, y)
        print @pastel.on_black(" " * @width)
      end
    end

    def should_print_facing?(frame)
      return frame % Constants::FRAMES_PER_SECOND > Constants::FRAMES_PER_SECOND / 2
    end
  end
end
