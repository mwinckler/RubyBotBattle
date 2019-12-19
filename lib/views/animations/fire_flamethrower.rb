require "tty-cursor"
require "pastel"

module Views
  module Animations
    class FireFlamethrower
      def initialize(position)
        @position = position
        @duration = 12

        pastel = Pastel.new
        @colors = [pastel.red.detach, pastel.bright_red.detach, pastel.yellow.detach, pastel.bright_yellow.detach]
      end

      def render(frame, render_offset)
        @initial_frame ||= frame
        @current_frame = frame

        color = @colors.sample()

        cursor = TTY::Cursor

        cursor_position = @position.translate(render_offset.x, render_offset.y)
        print cursor.move_to(cursor_position.x, cursor_position.y)
        print color.call('#')
      end

      def complete?()
        return !@initial_frame.nil? && @current_frame - @initial_frame > @duration
      end
    end
  end
end
