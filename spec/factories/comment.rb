FactoryBot.define do
  factory :comment do
    content { "コメント内容" }
    association :user
    association :post
  end
end
