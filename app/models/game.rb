# app/models/game.rb
class Game < ApplicationRecord
  has_many :frames, dependent: :destroy

  after_create :initialize_frames

  def initialize_frames
    10.times { frames.create! }
  end

  def current_frame
    frames.find { |f| !f.completed? }
  end

  def completed?
    frames.all?(&:completed?)
  end

  def total_score
    frames.sum(&:score)
  end
end
