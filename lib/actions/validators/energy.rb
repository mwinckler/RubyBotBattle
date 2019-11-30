require_relative "../../exceptions/insufficient_energy"

module Validators
  module Energy
    def self.validate(qty, bot_state)
      raise Exceptions::InsufficientEnergyError.new(bot_state.bot) unless bot_state.available_energy >= qty
    end
  end
end
