class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :favor_id
      t.integer :favored_id
      t.timestamps
    end
    add_index :favorites, :favor_id
    add_index :favorites, :favored_id
    add_index :favorites, [:favor_id, :favored_id], unique: true
  end
end
