require "tty-cursor"
require "pastel"

module Views
  module Animations
    class FireLaser
      def initialize(origin_point, hit_point)
        @origin_point = origin_point
        @hit_point = hit_point

        @pastel = Pastel.new
        @initial_frame = nil
        @duration = 1
        @latest_frame = nil
      end

      def render(frame, render_offset)
        return nil if complete?()
        @initial_frame ||= frame
        @latest_frame = frame

        dx = 0
        dy = 0

        # Draw a red line from origin to hit point.
        # For the time being, assume orthogonal directions.
        if @origin_point.x < @hit_point.x
          dx = 1
        elsif @origin_point.x > @hit_point.x
          dx = -1
        end

        if @origin_point.y < @hit_point.y
          dy = 1
        elsif @origin_point.y > @hit_point.y
          dy = -1
        end

        current_point = @origin_point.translate(render_offset.x, render_offset.y).translate(dx, dy)
        end_point = @hit_point.translate(render_offset.x, render_offset.y)
        laser_color = @pastel.red.detach
        cursor = TTY::Cursor
        line_char = dx != 0 ? "-" : "|"

        while current_point != end_point
          print cursor.move_to(current_point.x, current_point.y)
          print laser_color.call(line_char)
          current_point.translate!(dx, dy)
        end
      end

      def complete?()
        return false if @latest_frame.nil? || @initial_frame.nil?
        return @latest_frame - @duration >= @initial_frame
      end
    end
  end
end
