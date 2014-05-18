class CreateInventoryFiles < ActiveRecord::Migration
  def self.up
    create_table :inventory_files do |t|
      t.string :filename
      t.string :content_type
      t.integer :size
      t.integer :user_id
      t.text :note

      t.timestamps
    end
    add_index :inventory_files, :user_id
  end

  def self.down
    drop_table :inventory_files
  end
end
