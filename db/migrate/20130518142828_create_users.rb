class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :email
      t.string :avatar
      t.string :token
      t.timestamps
    end

    add_index :users, [:provider, :uid, :nickname]

    add_column :photos, :owner_id, :integer
    add_index :photos, :owner_id

    add_column :users, :photos_count, :integer, default: 0
  end
end
