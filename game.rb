require "tty-prompt"
require "tty-cursor"

require_relative "lib/bot_factory"
require_relative "lib/constants"
require_relative "lib/models/arena"
require_relative "lib/models/arena_configuration"
require_relative "lib/screen"
require_relative "lib/views/arena"
require_relative "lib/views/animations/animation_manager"

class Game
  def initialize()
    input = nil
    menu = nil
    arena_view = nil
    current_screen = Screen::MAIN_MENU
    selected_bots = []
    bot_states = nil

    arena_config = Models::ArenaConfiguration.new(
      Constants::ARENA_WIDTH,
      Constants::ARENA_HEIGHT,
      Constants::STARTING_ENERGY,
      Constants::STARTING_HEALTH,
      Constants::MAX_TURNS
    )

    prompt = TTY::Prompt.new()
    bot_factory = BotFactory.new()
    frame = 0

    animation_manager = Views::Animations::AnimationManager.new()

    while true do
      case current_screen
      when Screen::MAIN_MENU
        current_screen = main_menu()
        next
      when Screen::BOT_SELECTION
        bots_found = bot_factory.available_bots(relative_base_dir())

        if bots_found[:invalid].any?
          puts "Warning: The following bot classes were found but had errors: #{bots_found[:invalid]}"
        end

        if bots_found[:available].empty?
          prompt.keypress("No valid bots found in the `bots` directory! Press any key to go back...")
          current_screen = Screen::MAIN_MENU
          next
        end

        selected_bots = select_bots(bots_found[:available]).map { |klass| klass.new() }.shuffle()
        clear_screen()
        current_screen = Screen::ARENA
        arena_model = Models::Arena.new(arena_config, animation_manager, selected_bots)
        arena_view = Views::Arena.new(arena_config.width, arena_config.height, selected_bots)
      when Screen::ARENA
        frame += 1

        if (bot_states.nil? || frame % Constants::FRAMES_PER_ACTION == 1) && !arena_model.game_over?()
          turn_results = arena_model.execute_turn()
          bot_states = turn_results.bot_states
        end

        arena_view.render(
          arena_model.unsafe_game_state(),
          bot_states,
          frame,
          animation_manager.animations
        )

        animation_manager.clear()

        if arena_model.game_over?() && arena_view.animations_complete?()
          current_screen = Screen::POST_FIGHT
        end
      when Screen::POST_FIGHT
        if arena_model.winner.nil?
          puts "DRAW: You're all losers!"
          break
        end

        puts "WINNER: #{arena_model.winner.bot.display_name()}"
        break
      when Screen::QUIT
        break
      end

      break if prompt.keypress("", timeout: 1.0 / Constants::FRAMES_PER_SECOND, keys: [:escape])
    end

    puts "Thanks for playing!"
  end

  private

  def main_menu()
    clear_screen()
    prompt = TTY::Prompt.new()

    options = {
      "Quick battle": Screen::BOT_SELECTION,
      "Quit": Screen::QUIT
    }

    return prompt.select("Welcome to BotBattle!", options)
  end

  def select_bots(available_bots)
    clear_screen()
    prompt = TTY::Prompt.new()

    opts = available_bots.to_h { |klass| [klass.new().display_name(), klass]}
    prompt.on(:keyescape) { |key| return [] }
    loop do
      selection = prompt.multi_select(
        "Who shall fight?",
        opts,
        echo: false,
        cycle: true,
        per_page: 10
      )

      if selection.length == 1
        prompt.say("You must pick at least two bots to fight.")
      else
        return selection
      end
    end
  end

  def show_fight_summary(fight_results)
    clear_screen()
    puts "And the winner is: #{fight_results[:winner]}!"
  end

  def clear_screen()
    print TTY::Cursor.clear_screen()
    print TTY::Cursor.move_to(0, 0)
  end

  def relative_base_dir()
    return File.dirname($0)
  end
end

Game.new()
