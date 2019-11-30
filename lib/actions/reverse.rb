require_relative "movement_base"

module Actions
  class Reverse < MovementBase
    def self.execute(game_state, bot_state)
      return super(game_state, bot_state, -1)
    end
  end
end
