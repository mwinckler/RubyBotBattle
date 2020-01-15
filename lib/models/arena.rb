require_relative "bot_state"
require_relative "game_state"
require_relative "../actions/factory"
require_relative "filtered_game_state"
require_relative "point"
require_relative "size"
require_relative "turn_result"
require_relative "../exceptions/insufficient_energy"
require_relative "../exceptions/invalid_direction"

module Models
  class Arena
    def initialize(arena_configuration, bots)
      @valid_facings = [:north, :east, :south, :west]

      @config = arena_configuration
      @bot_states = create_bot_states(bots)
      @bots = bots
      @turn = 0
    end

    def execute_turn()
      @turn += 1
      actions = {}
      @bots.each do |bot|
        # TODO: Decide for sure whether to have bots all act simultaneously
        # or whether to make this turn-based in which the second bot could
        # react to the first bot's action
        # For now, keep all actions simultaneous - no instant reactions,
        # though they will be resolved in turn order (e.g. bot 2 will not
        # be able to evade a laser being fired by bot 1)
        actions[bot] = bot.act(
          game_state_for(bot),
          safe_bot_state_for(bot)
        )
      end

      # With all actions selected, execute them in turn order.
      # The action excutor is expected to mutate game state, as the action
      # may affect multiple bots. We are intentionally passing it the
      # pointer to the real game and bot states, not clones.
      unsafe_game_state = create_unsafe_game_state
      action_results = []
      @bots.each do |bot|
        begin
          action_results << Actions::Factory.create_executor(unsafe_game_state, actions[bot]).call(@bot_states[bot])
        rescue Exceptions::InsufficientEnergyError => e
          # TODO: Add an animation to indicate the energy shortage
          # Suppress error for now
        rescue Exceptions::InvalidDirectionError => e
          # TODO: Add a message alerting the programmer of the invalid directions
          # For now, make the failure dramatic
          raise
        end
      end

      @bots.reject! {|bot| @bot_states[bot].health <= 0 }
      @bot_states.reject! {|bot, state| state.health <= 0 }

      return Models::TurnResult.new(action_results, safe_bot_states())
    end

    # Returns a clone of game state objects to ensure bots cannot manipulate states.
    # This method should always be used when passing states outside this class.
    def safe_bot_states()
      return @bot_states.values.map{|state| state.clone}
    end

    def unsafe_game_state()
      return create_unsafe_game_state()
    end

    def game_over?()
      # The fight is over if there is one or fewer bots remaining with any health left,
      # or if the total time elapsed has exceeded the maximum configured.
      return living_bots().count <= 1 || @turn > @config.max_turns
    end

    def winner()
      return nil if living_bots.empty? || living_bots.count > 1
      return living_bots.first
    end

    private

    def create_bot_states(bots)
      starting_positions = []
      states = Hash.new

      bots.each do |bot|
        position = random_unoccupied_position(starting_positions)
        starting_positions.push(position)
        states[bot] = BotState.new(
          bot,
          @config.starting_energy,
          @config.starting_health,
          @valid_facings.sample(),
          position
        )
      end

      return states
    end

    def random_unoccupied_position(existing_positions)
      loop do
        position = Models::Point.new(rand(0..@config.width - 1), rand(0..@config.height - 1))
        return position unless existing_positions.any? {|pos| pos.x == position.x && pos.y == position.y}
      end
    end

    def living_bots()
      return @bot_states.values.filter {|state| state.alive?() }
    end

    def create_unsafe_game_state()
      return GameState.new(
        @turn,
        Models::Size.new(@config.width, @config.height),
        @bot_states.values
      )
    end

    def game_state_for(bot)
      # For now, just return the truth. Later, maybe add some fog of war
      # and lie about things if the bot's damaged or being jammed.
      return FilteredGameState.new(
        Models::Size.new(@config.width, @config.height),
        safe_bot_states.reject {|state| state.bot == bot}
      )
    end

    def safe_bot_state_for(bot)
      return @bot_states[bot].clone
    end
  end
end