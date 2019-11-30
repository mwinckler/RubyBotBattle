module Models
  class FilteredGameState
    attr_reader :arena_size, :enemies

    def initialize(arena_size, enemies)
      @arena_size = arena_size
      @enemies = enemies
    end
  end
end
