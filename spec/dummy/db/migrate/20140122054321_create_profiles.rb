class CreateProfiles < ActiveRecord::Migration
  def change
    if ENV['ENJU_ID_TYPE'] == 'uuid'
      options = {id: :uuid, default: 'gen_random_uuid()'}
    else
      options = {}
    end
    create_table :profiles, options do |t|
      t.references :user, index: true, foreign_key: true
      t.references :user_group, index: true
      t.references :library, index: true
      t.string :locale
      t.string :user_number
      t.text :full_name
      t.text :note
      t.text :keyword_list
      t.references :required_role, index: false

      t.timestamps
    end

    add_index :profiles, :user_number, unique: true
  end
end
