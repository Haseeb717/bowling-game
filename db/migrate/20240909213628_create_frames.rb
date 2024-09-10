# frozen_string_literal: true

class CreateFrames < ActiveRecord::Migration[7.0]
  def change
    create_table :frames do |t|
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
