module Actions
  module Animations
    class Lunge
      attr_reader :origin, :destination

      def initialize(origin, destination)
        @origin = origin
        @destination = destination
      end
    end
  end
end
