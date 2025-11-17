FactoryBot.define do
  factory :character do
    name { "キャラクター名" }
    association :work
  end
end
