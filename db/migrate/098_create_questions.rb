class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true, null: false
      t.text :body
      t.boolean :shared, default: true, null: false
      t.integer :answers_count, default: 0, null: false
      t.datetime :deleted_at
      t.string :state
      t.boolean :solved, null: false, default: false
      t.text :note

      t.timestamps
    end
  end
end
