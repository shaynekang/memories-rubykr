class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :comment
      t.string :image
      t.timestamps
    end
  end
end
