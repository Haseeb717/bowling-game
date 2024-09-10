# frozen_string_literal: true

# spec/models/game_spec.rb
require 'rails_helper'

RSpec.describe Game, type: :model do
  subject(:game) { described_class.create }

  it 'initializes with 10 frames' do
    expect(game.frames.size).to eq(10)
  end

  describe '#current_frame' do
    context 'when no rolls have been made' do
      it 'returns the first frame' do
        expect(game.current_frame).to eq(game.frames.first)
      end
    end

    context 'when frames are completed' do
      before do
        game.frames.first.rolls.create!(pins_knocked_down: 10)
      end

      it 'returns the first incomplete frame' do
        expect(game.current_frame).to eq(game.frames.second)
      end
    end
  end

  describe '#total_score' do
    let(:frame1) { game.frames.first }
    let(:frame2) { game.frames.second }

    it 'calculates the total score' do
      frame1.rolls.create(pins_knocked_down: 5)
      frame1.rolls.create(pins_knocked_down: 4)

      frame2.rolls.create(pins_knocked_down: 3)
      frame2.rolls.create(pins_knocked_down: 6)

      expect(game.total_score).to eq(18)
    end
  end

  describe '#completed?' do
    context 'when all frames are completed' do
      before do
        game.frames[0..8].each do |frame|
          frame.rolls.create!(pins_knocked_down: 10)
        end

        last_frame = game.frames.last
        last_frame.rolls.create!(pins_knocked_down: 10) # Strike
        last_frame.rolls.create!(pins_knocked_down: 10) # Bonus roll 1
        last_frame.rolls.create!(pins_knocked_down: 10) # Bonus roll 2
      end

      it 'returns true' do
        expect(game).to be_completed
      end
    end

    context 'when there are incomplete frames' do
      it 'returns false' do
        expect(game).not_to be_completed
      end
    end
  end
end
