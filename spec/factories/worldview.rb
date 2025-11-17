FactoryBot.define do
  factory :worldview do
    country { "国名" }
    culture { "文化" }
    association :work
  end
end
