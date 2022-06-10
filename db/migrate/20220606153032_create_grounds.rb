class CreateGrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :grounds do |t|
      t.string :name
      t.integer :prep, default: 0
      t.integer :player_count, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
