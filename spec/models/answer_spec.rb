# -*- encoding: utf-8 -*-
require 'rails_helper'

describe Answer do
  #pending "add some examples to (or delete) #{__FILE__}"

end

# == Schema Information
#
# Table name: answers
#
#  id                   :bigint(8)        not null, primary key
#  user_id              :integer          not null
#  question_id          :integer          not null
#  body                 :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  deleted_at           :datetime
#  shared               :boolean          default(TRUE), not null
#  state                :string
#  item_identifier_list :text
#  url_list             :text
#
