# frozen_string_literal: true

# spec/models/frame_spec.rb
require 'rails_helper'

RSpec.describe Frame, type: :model do
  let(:game) { Game.create }
  subject(:frame) { game.frames.first }

  describe '#completed?' do
    context 'when it is a strike' do
      before do
        frame.rolls.create(pins_knocked_down: 10)
      end

      it 'marks the frame as completed' do
        expect(frame).to be_completed
      end
    end

    context 'when there are two rolls and less than 10 pins knocked down' do
      before do
        frame.rolls.create(pins_knocked_down: 3)
        frame.rolls.create(pins_knocked_down: 6)
      end

      it 'marks the frame as completed' do
        expect(frame).to be_completed
      end
    end

    context 'when the frame is incomplete' do
      before do
        frame.rolls.create(pins_knocked_down: 3)
      end

      it 'does not mark the frame as completed' do
        expect(frame).not_to be_completed
      end
    end
  end
end
