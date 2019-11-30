module Models
  class BotState
    attr_accessor :bot, :available_energy, :health, :facing, :position
    def initialize(bot, available_energy, health, facing, position)
      @bot = bot
      @available_energy = available_energy
      @health = health
      @facing = facing
      @position = position
    end

    def alive?()
      return @health > 0
    end
  end
end
