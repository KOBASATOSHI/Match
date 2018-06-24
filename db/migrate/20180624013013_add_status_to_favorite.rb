class AddStatusToFavorite < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :status, :integer ,limit: 1, default: 0
  end
end
