class CreateAnswerHasItems < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_has_items do |t|
      t.references :answer, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false, type: :uuid
      t.integer :position

      t.timestamps
    end
  end
end
