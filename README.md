# Bot Battle

This is a simple bot-battling framework designed to make it more fun to learn Ruby. To get started, run:

```
bundle
ruby game.rb
```

Choose "Start a battle", follow the prompts to select your combatants, and enjoy the show!

## Creating bots

The real fun starts when you define your own bot to fight in the arena. The game attempts to load bots from the [./bots](./bots) directory. You can see an example bot class in [./bots/d_bot.rb](./bots/d_bot.rb). To make your own bot AI, you must:

* Create a new file in the `bots` directory and give it a name corresponding to your class name. The file must be in `snake_case` and the class name in `TitleCase`. For example, if your bot class is named `KillerBot`, the filename would be `killer_bot.rb`.
* In the new file, define a class (with the name matching the filename as just described). This class must provide a constructor (`initialize(max_health)`) and two public methods: `name` and `act`.
  * The `name` method must return a string that is the human-readable bot name. This can be whatever you like.
  * The `act` method must take two arguments: `GameState` and `BotState`. The first is an object defining the current state of the world (as your bot sees it - this could differ from reality!) and the second is an object defining the current state of your bot (available energy, position on the field, direction it is facing, etc.). The `act` method must return a symbol indicating which action your bot is going to take. (More on this below.)

During a fight, the game orchestrator will instantiate your bot class and each time it is your bot's turn to do something, the orchestrator will call the `act` method with the current game state and your bot's state. Your bot must then decide what to do based on the available information.

### The `act` method in detail

Your bot's `act` method should evaluate the current game and bot state and decide on an action to take. The first argument, `game_state`, will include the following properties:

* `arena_size` (`Struct(:width, :height)`) - a struct with two properties, `width` and `height`, representing the number of columns and rows in the arena respectively.
* `enemies` (array of `BotState`) - an array of `BotState` objects, each representing the current state of an enemy on the map.

The second argument to `act`, `bot_state`, includes information about your bot's current condition. Properties include:

* `available_energy` (int) - how much energy your bot currently has.
* `health` (int) - how many hitpoints your bot has remaining.
* `facing` (symbol) - the direction your bot is currently facing. Valid values include `:north`, `:east`, `:south`, and `:west`.
* `position` (`Struct(:x, :y`)) - the X and Y coordinates of your bot on the current arena. 0,0 is the top left corner of the arena.

With this information, you must decide which action to take and return a symbol from the `act` method. Valid actions are as follows (each symbol is followed by its cost in energy):

* `:face_north` (1 energy) - face your bot north.
* `:face_east` (1 energy) - face your bot east.
* `:face_south` (1 energy) - face your bot south.
* `:face_west` (1 energy) - face your bot west.
* `:advance` (1 energy) - move forward one space. This action costs 1 energy.
* `:reverse` (1 energy) - move backward one space. This action costs 1 energy.
* `:fire_laser` (5 energy) - fire your laser in the current direction you are facing.
* `:charge_battery` (0 energy) - sit still and regain energy for one second. The floor of the arena is designed to provide power to idle bots; for each turn you spend sitting still you regain 1 energy.