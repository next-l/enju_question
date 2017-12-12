FactoryBot.define do
  factory :question do |f|
    f.sequence(:body){|n| "question_#{n}"}
    f.user_id{FactoryBot.create(:user).id}
  end
end
