module Actions
  module Animations
    class Repair
      attr_reader :position

      def initialize(position)
        @position = position
      end
    end
  end
end
