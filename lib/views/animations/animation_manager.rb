require_relative "fire_laser"
require_relative "destroy_bot"
require_relative "lunge"
require_relative "repair"

module Views
  module Animations
    class AnimationManager
      attr_accessor :animations

      def initialize()
        @animations = []
      end

      def add_fire_laser(origin, hit_point)
        @animations.push(Views::Animations::FireLaser.new(origin, hit_point))
      end

      def add_destroy_bot(position)
        @animations.push(Views::Animations::DestroyBot.new(position))
      end

      def add_lunge(origin, destination)
        @animations.push(Views::Animations::Lunge.new(origin, destination))
      end

      def add_repair(position)
        @animations.push(Views::Animations::Repair.new(position))
      end

      def clear()
        @animations.clear()
      end
    end
  end
end
