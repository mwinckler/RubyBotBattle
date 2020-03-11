require "tty-cursor"
require "pastel"

require_relative "../../models/point"

module Views
  module Animations
    class Lunge
      def initialize(origin, destination)
        @origin = origin
        @destination = destination

        @frame_delay = 1
        @duration = [(origin.x - destination.x).abs, (origin.y - destination.y).abs].max * @frame_delay
        @current_point = origin
      end

      def render(frame, render_offset)
        return if complete?()
        @initial_frame ||= frame
        @current_frame = frame

        if (@current_frame - @initial_frame) % @frame_delay == 0
          @current_point.translate!(Models::Point.new(@destination.x <=> @current_point.x, @destination.y <=> @current_point.y))
        end

        render_point = @current_point.translate(render_offset)
        print TTY::Cursor.move_to(render_point.x, render_point.y)
        print 'X'
      end

      def complete?()
        return false if @initial_frame.nil?
        return @current_frame - @initial_frame >= @duration
      end
    end
  end
end
