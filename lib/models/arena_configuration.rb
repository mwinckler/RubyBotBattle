module Models
  class ArenaConfiguration
    attr_reader :width, :height, :starting_energy, :starting_health, :max_turns

    def initialize(width, height, starting_energy, starting_health, max_turns)
      @width = width
      @height = height
      @starting_energy = starting_energy
      @starting_health = starting_health
      @max_turns = max_turns
    end
  end
end