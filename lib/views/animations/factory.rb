require_relative "destroy_bot"
require_relative "fire_laser"
require_relative "lunge"

module Views
  module Animations
    class Factory
      def self.create_from(model)
        if model.is_a?(Actions::Animations::FireLaser)
          return Views::Animations::FireLaser.new(model)
        elsif model.is_a?(Actions::Animations::DestroyBot)
          return Views::Animations::DestroyBot.new(model)
        elsif model.is_a?(Actions::Animations::Lunge)
          return Views::Animations::Lunge.new(model)
        else
          raise StandardError.new("Unable to find animation view for #{model}")
        end
      end
    end
  end
end
