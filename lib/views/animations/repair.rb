require "tty-cursor"
require "pastel"

require_relative "../../models/point"
require_relative "components/character_sequence"

module Views
  module Animations
    class Repair
      def initialize(model)
        @position = model.position
        @child_views = []
        @pastel = Pastel.new()
      end

      def render(frame, render_offset)
        return if !@initial_frame.nil? && complete?()
        @initial_frame ||= frame
        @frame = frame

        case relative_frame()
        when 0
          @child_views << create_repair_character(@position.translate(-1, 0))
        when 1
          @child_views << create_repair_character(@position.translate(0, -1))
        when 2
          @child_views << create_repair_character(@position.translate(1, 0))
        when 3
          @child_views << create_repair_character(@position.translate(0, 1))
        end

        @child_views.each{|view| view.render(frame, render_offset)}
      end

      def complete?()
        return @child_views.all?{|view| view.complete?() }
      end

      private

      def relative_frame()
        return @frame - (@initial_frame || 0)
      end

      def create_repair_character(position)
        return Views::Animations::Components::CharacterSequence.new(@pastel.green.detach(), position, ["+", " "] * 2, 1)
      end
    end
  end
end
