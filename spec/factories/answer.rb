FactoryBot.define do
  factory :answer do |f|
    f.sequence(:body){|n| "answer_#{n}"}
    f.question_id{FactoryBot.create(:question).id}
    f.user_id{FactoryBot.create(:user).id}
  end
end
