FactoryBot.define do
  factory :ai_consultation do
    content { "相談内容" }
    association :user
  end
end
