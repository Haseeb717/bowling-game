# frozen_string_literal: true

# spec/requests/games_spec.rb
require 'rails_helper'

RSpec.describe 'Games API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => user.api_key.to_s, 'Content-Type' => 'application/json' } }

  describe 'POST /api/v1/games' do
    it 'creates a new game' do
      post('/api/v1/games', headers:)
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['status']).to eq('New game started')
    end
  end

  describe 'GET /api/v1/games/:id' do
    let!(:game) { Game.create }

    it 'returns the current game status' do
      get("/api/v1/games/#{game.id}", headers:)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['game_id']).to eq(game.id)
      expect(json['total_score']).to eq(0)
      expect(json['frames'].length).to eq(10)
    end
  end
end
