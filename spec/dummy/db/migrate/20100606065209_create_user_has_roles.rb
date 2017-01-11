class CreateUserHasRoles < ActiveRecord::Migration
  def change
    create_table :user_has_roles do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :role, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
