# app/controllers/rolls_controller.rb
module Api
  module V1
    class RollsController < ApplicationController
      def create
        game = Game.find(params[:game_id])
        frame = game.current_frame

        if game.completed?
          render json: { error: 'Game already completed' }, status: :unprocessable_entity
        elsif frame.completed?
          render json: { error: 'Frame already completed' }, status: :unprocessable_entity
        else
          frame.add_roll(params[:pins])
          render json: { frame_id: frame.id, frame_score: frame.score, total_score: game.total_score }
        end
      end
    end
  end
end
