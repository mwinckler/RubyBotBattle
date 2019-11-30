require_relative "advance"
require_relative "reverse"
require_relative "charge_battery"
require_relative "face"
require_relative "fire_laser"
require_relative "../exceptions/invalid_action"

module Actions
  class Factory
    def self.create_executor(unsafe_game_state, action_name)
      case action_name
      when :advance
        return Advance.method(:execute).curry.call(unsafe_game_state)
      when :reverse
        return Reverse.method(:execute).curry.call(unsafe_game_state)
      when :charge_battery
        return ChargeBattery.method(:execute)
      when /^face_\w+/
        direction = parse_arg(action_name).to_sym
        return Face.method(:execute).curry.call(direction)
      when :fire_laser
        return FireLaser.method(:execute).curry.call(unsafe_game_state)
      else
        raise Exceptions::InvalidActionError.new(action_name)
      end
    end

    def self.parse_arg(action_name)
      return action_name.to_s.split('_').last()
    end
  end
end