FactoryBot.define do
  factory :plot do
    chapter_title { "第1章" }
    association :work
  end
end
