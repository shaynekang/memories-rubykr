class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.references :photo
      t.datetime :liked_at
    end

    add_index :likes, [:user_id, :photo_id]
  end
end
