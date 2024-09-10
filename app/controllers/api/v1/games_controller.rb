# app/controllers/games_controller.rb
module Api
  module V1
    class GamesController < ApplicationController
      def create
        game = Game.create!
        render json: { id: game.id, status: 'New game started' }, status: :created
      end

      def show
        game = Game.find(params[:id])
        render json: { game_id: game.id, frames: game.frames.map(&:score), total_score: game.total_score }
      end
    end
  end
end
