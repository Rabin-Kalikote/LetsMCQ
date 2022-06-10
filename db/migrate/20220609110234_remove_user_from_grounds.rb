class RemoveUserFromGrounds < ActiveRecord::Migration[5.2]
  def change
    remove_reference :grounds, :user, foreign_key: true
  end
end
