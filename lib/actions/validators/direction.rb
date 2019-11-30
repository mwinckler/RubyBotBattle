require_relative "../../exceptions/invalid_direction"

module Validators
  module Direction
    def self.validate(direction)
      valid_directions = [
        :north,
        :east,
        :south,
        :west
      ]

      raise ArgumentError.new("`direction` argument '#{direction}' must be a symbol") unless direction.is_a?(Symbol)
      raise InvalidDirectionError.new(direction) unless valid_directions.include?(direction)
    end
  end
end
