class CreateRolls < ActiveRecord::Migration[7.0]
  def change
    create_table :rolls do |t|
      t.references :frame, null: false, foreign_key: true
      t.integer :pins_knocked_down

      t.timestamps
    end
  end
end
