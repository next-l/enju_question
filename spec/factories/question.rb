FactoryBot.define do
  factory :question do
    sequence(:body){|n| "question_#{n}"}
    association :user, factory: :user
  end
end
