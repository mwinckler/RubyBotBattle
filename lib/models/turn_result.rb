module Models
  class TurnResult
    attr_accessor :action_results, :bot_states

    def initialize(action_results, bot_states)
      @action_results = action_results
      @bot_states = bot_states
    end
  end
end
