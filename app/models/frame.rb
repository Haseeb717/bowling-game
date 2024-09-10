# frozen_string_literal: true

# app/models/frame.rb
class Frame < ApplicationRecord
  belongs_to :game
  has_many :rolls, dependent: :destroy

  def add_roll(pins)
    rolls.create!(pins_knocked_down: pins)
  end

  def completed?
    if tenth_frame?
      (rolls.count == 2 && score < 10) || rolls.count == 3
    else
      strike? || rolls.count == 2
    end
  end

  def score
    return strike_score if strike?
    return spare_score if spare?

    regular_score
  end

  def strike?
    rolls.first&.pins_knocked_down == 10
  end

  def spare?
    rolls.count == 2 && regular_score == 10
  end

  def regular_score
    rolls.sum(:pins_knocked_down)
  end

  private

  def strike_score
    next_two_rolls = next_two_rolls()
    return 10 + next_two_rolls.sum(&:pins_knocked_down) if next_two_rolls.size == 2

    0
  end

  def spare_score
    return 10 + next_frame_first_roll if next_frame_first_roll

    0
  end

  def next_two_rolls
    next_rolls = game.frames.where('id > ?', id).flat_map(&:rolls)
    next_rolls.first(2)
  end

  def next_frame_first_roll
    game.frames.where('id > ?', id).first&.rolls&.first&.pins_knocked_down
  end

  def tenth_frame?
    game.frames.last == self
  end
end
