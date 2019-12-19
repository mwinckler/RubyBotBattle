require_relative "../constants"
require_relative "validators/energy"
require_relative "result"

module Actions
  class FireFlamethrower
    def self.execute(animation_manager, game_state, bot_state)
      Validators::Energy.validate(Constants::FLAMETHROWER_COST, bot_state)

      bot_state.available_energy -= Constants::FLAMETHROWER_COST

      burning_locations = affected_points(bot_state)

      burning_locations.each do |point|
        next if !game_state.in_bounds?(point)

        victim = game_state.bot_at(point)

        if !victim.nil?
          victim.set_condition(:burning)
          victim.health -= 1
        end
      end

      animation_manager.add_burning_animations(burning_locations)
    end

    private

    def self.affected_points(bot_state)
      points = []
      transforms = {
        north: ->(pt, i) { pt.translate(0, -i) },
        east: ->(pt, i) { pt.translate(i, 0) },
        south: ->(pt, i) { pt.translate(0, i) },
        west: ->(pt, i) { pt.translate(-i, 0) }
      }

      (1..3).each do |i|
        center_point = transforms[bot_state.facing].(bot_state.position, i)

        points << center_point

        next unless i > 1

        spread_directions = [:north, :south].include?(bot_state.facing) ? [:east, :west] : [:north, :south]
        spread_directions.each do |direction|
          (1..i-1).each { |j| points << transforms[direction].(center_point, j) }
        end
      end

      return points
    end
  end
end
