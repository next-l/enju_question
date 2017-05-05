class CreateAnswerHasItems < ActiveRecord::Migration[5.0]
  def self.up
    create_table :answer_has_items do |t|
      t.integer :answer_id
      t.integer :item_id
      t.integer :position

      t.timestamps
    end
    add_index :answer_has_items, :answer_id
    add_index :answer_has_items, :item_id
  end

  def self.down
    drop_table :answer_has_items
  end
end
