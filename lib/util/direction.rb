require_relative "../models/point"

module Util
  class Direction
    def self.translate(direction, distance = 1)
      x = 0
      y = 0

      case direction
      when :north
        y = -1 * distance
      when :east
        x = distance
      when :south
        y = distance
      when :west
        x = -1 * distance
      end

      return Models::Point.new(x, y)
    end
  end
end
