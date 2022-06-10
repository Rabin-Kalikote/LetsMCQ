class RenamePlayerCountToStatus < ActiveRecord::Migration[5.2]
  def change
    rename_column :grounds, :player_count, :status
  end
end
