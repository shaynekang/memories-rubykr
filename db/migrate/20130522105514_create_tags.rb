class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggings do |t|
      t.references :photo
      t.references :tag
      t.timestamps
    end

    add_index :taggings, [:photo_id, :tag_id]
  end
end
