module Actions
  module Animations
    class DestroyBot
      attr_reader :position

      def initialize(position)
        @position = position
      end
    end
  end
end
