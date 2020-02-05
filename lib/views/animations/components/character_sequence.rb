require "tty-cursor"

module Views
  module Animations
    module Components
      class CharacterSequence
        def initialize(font_lambda, position, characters, frames_per_character)
          @font_lambda = font_lambda
          @position = position
          @characters = characters
          @frames_per_character = frames_per_character
          @character_index = -1
        end

        def render(frame, render_offset)
          return if !@initial_frame.nil? && complete?()
          @initial_frame ||= frame
          @current_frame = frame

          pt = @position.translate(render_offset)
          print TTY::Cursor.move_to(pt.x, pt.y)

          if (@current_frame - @initial_frame) % @frames_per_character == 0
            @character_index += 1
          end

          print @font_lambda.(@characters[@character_index])
        end

        def complete?()
          return @current_frame - @initial_frame > @frames_per_character * @characters.count
        end
      end
    end
  end
end
