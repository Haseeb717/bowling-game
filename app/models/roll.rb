# app/models/roll.rb
class Roll < ApplicationRecord
  belongs_to :frame

  validates :pins_knocked_down, inclusion: { in: 0..10 }
end
