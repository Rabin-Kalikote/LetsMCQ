class CreateGroundPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :ground_players do |t|
      t.references :ground, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score, default: 0
      t.boolean :is_organizer, default: false

      t.timestamps
    end
  end
end
