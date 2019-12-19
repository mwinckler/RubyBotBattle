require "tty-cursor"
require "pastel"

require_relative "../../models/point"

module Views
  module Animations
    class Lunge
      def initialize(model)
        @model = model

        @frame_delay = 1
        @duration = [(model.origin.x - model.destination.x).abs, (model.origin.y - model.destination.y).abs].max * @frame_delay
        @current_point = @model.origin
      end

      def render(frame, render_offset)
        return if complete?()
        @initial_frame ||= frame
        @current_frame = frame

        if (@current_frame - @initial_frame) % @frame_delay == 0
          @current_point.translate!(Models::Point.new(@model.destination.x <=> @current_point.x, @model.destination.y <=> @current_point.y))
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
