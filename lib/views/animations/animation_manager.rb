require_relative "fire_laser"
require_relative "fire_flamethrower"
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

      def add_burning_animations(locations)
        @animations.concat(locations.map { |location| Views::Animations::FireFlamethrower.new(location) })
      end

      def render(frame, render_offset)
        @animations.each { |animation| animation.render(frame, render_offset) }
        remove_completed_animations()
      end

      def animations_complete?()
        return @animations.empty?()
      end

      def render(frame, render_offset)
        @animations.each { |animation| animation.render(frame, render_offset) }
        remove_completed_animations()
      end

      private

      def remove_completed_animations()
        @animations.reject! { |animation| animation.complete?() }
      end
    end
  end
end
