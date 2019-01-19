class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :user, foreign_key: true, null: false
      t.references :question, foreign_key: true, null: false
      t.text :body
      t.timestamps
      t.datetime :deleted_at
      t.boolean :shared, default: true, null: false
      t.string :state
      t.text :item_identifier_list
      t.text :url_list
    end
  end
end
