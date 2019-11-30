require_relative "../util/direction"

module Models
  class GameState
    attr_accessor :arena_size, :bot_states, :turn

    def initialize(turn, arena_size, bot_states)
      @turn = turn
      @arena_size = arena_size
      @bot_states = bot_states
    end

    def bot_at(point)
      return bot_states.find { |state| state.position == point }
    end

    def first_occupied(from_point, in_direction)
      translation = Util::Direction.translate(in_direction, 1)
      pt = from_point.clone.translate!(translation.x, translation.y)

      while !occupied?(pt) && in_bounds?(pt)
        pt.translate!(translation.x, translation.y)
      end

      return pt
    end

    def occupied?(point)
      return bot_states.any? { |state| state.position == point }
    end

    def in_bounds?(point)
      return point.x >= 0 &&
        point.y >= 0 &&
        point.x < arena_size.width &&
        point.y < arena_size.height
    end
  end
end
