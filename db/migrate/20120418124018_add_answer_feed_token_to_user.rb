class AddAnswerFeedTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :answer_feed_token, :string
    add_index :users, :answer_feed_token, :unique => true
  end
end
