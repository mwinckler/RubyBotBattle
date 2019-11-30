module Actions
  module Animations
    class FireLaser
      attr_reader :origin_point, :hit_point

      def initialize(origin_point, hit_point)
        @origin_point = origin_point
        @hit_point = hit_point
      end
    end
  end
end
