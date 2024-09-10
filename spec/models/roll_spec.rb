# frozen_string_literal: true

# spec/models/roll_spec.rb
require 'rails_helper'

RSpec.describe Roll, type: :model do
  let(:frame) { Frame.create(game: Game.create) }

  describe 'validations' do
    it 'allows pins knocked down between 0 and 10' do
      expect(frame.rolls.create(pins_knocked_down: 0)).to be_valid
      expect(frame.rolls.create(pins_knocked_down: 10)).to be_valid
    end

    it 'does not allow pins knocked down outside 0-10 range' do
      expect(frame.rolls.create(pins_knocked_down: -1)).to_not be_valid
      expect(frame.rolls.create(pins_knocked_down: 11)).to_not be_valid
    end
  end
end
