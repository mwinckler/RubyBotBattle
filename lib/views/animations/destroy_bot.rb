require "pastel"
require "tty-cursor"

module Views
  module Animations
    class DestroyBot
      def initialize(model)
        @position = model.position
        @cursor = TTY::Cursor
        @pastel = Pastel.new()
        @duration = 5
      end

      def render(frame, render_offset)
        @initial_frame ||= frame
        @latest_frame = frame

        render_location = @position.translate(render_offset.x, render_offset.y)

        print @cursor.move_to(render_location.x, render_location.y)
        print @pastel.yellow("*")

        case frame - @initial_frame
        when 1..3
          print @cursor.move_to(render_location.x - 1, render_location.y - 1)
          print @pastel.yellow("\\|/")
          print @cursor.move_to(render_location.x - 1, render_location.y)
          print @pastel.yellow("-")
          print @cursor.move_to(render_location.x + 1, render_location.y)
          print @pastel.yellow("-")
          print @cursor.move_to(render_location.x - 1, render_location.y + 1)
          print @pastel.yellow("/|\\")
        when 4..6
          print @cursor.move_to(render_location.x - 1, render_location.y - 1)
          print @pastel.yellow("`^'")
          print @cursor.move_to(render_location.x - 1, render_location.y)
          print @pastel.yellow("~")
          print @cursor.move_to(render_location.x + 1, render_location.y)
          print @pastel.yellow("~")
          print @cursor.move_to(render_location.x - 1, render_location.y + 1)
          print @pastel.yellow(",.,")
        end
      end

      def complete?()
        return @latest_frame - @duration >= @initial_frame
      end
    end
  end
end
