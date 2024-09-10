# frozen_string_literal: true

# spec/requests/rolls_spec.rb
require 'rails_helper'

RSpec.describe 'Rolls API', type: :request do
  let!(:game) { Game.create }
  let!(:frame) { game.frames.first }
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => user.api_key.to_s } }

  describe 'POST /api/v1/games/:game_id/rolls' do
    context 'when the game is ongoing' do
      it 'adds a roll to the current frame' do
        post("/api/v1/games/#{game.id}/rolls", params: { pins: 5 }, headers:)
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['frame_score']).to eq(5)
        expect(json['total_score']).to eq(5)
      end
    end

    # spec/requests/rolls_spec.rb
    context 'when the game is completed' do
      before do
        # Simulate all frames being completed by adding two rolls to each frame
        game.frames.each do |frame|
          frame.rolls.create!(pins_knocked_down: 5)
          frame.rolls.create!(pins_knocked_down: 4) # Total 9 pins per frame
        end
      end

      it 'does not allow further rolls' do
        post("/api/v1/games/#{game.id}/rolls", params: { pins: 5 }, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Game already completed')
      end
    end
  end
end
