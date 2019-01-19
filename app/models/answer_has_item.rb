class AnswerHasItem < ActiveRecord::Base
  belongs_to :answer
  belongs_to :item

  validates_uniqueness_of :item_id, scope: :answer_id
  acts_as_list scope: :answer_id
end

# == Schema Information
#
# Table name: answer_has_items
#
#  id         :bigint(8)        not null, primary key
#  answer_id  :bigint(8)        not null
#  item_id    :bigint(8)        not null
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
