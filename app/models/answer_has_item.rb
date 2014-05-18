class AnswerHasItem < ActiveRecord::Base
  #attr_accessible :answer_id, :item_id
  belongs_to :answer
  belongs_to :item

  validates_uniqueness_of :item_id, :scope => :answer_id
  acts_as_list :scope => :answer_id
end

# == Schema Information
#
# Table name: answer_has_items
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  item_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

