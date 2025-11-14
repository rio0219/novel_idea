FactoryBot.define do
  factory :work do
    uuid { SecureRandom.uuid }
    title { "テスト作品" }
    association :user
    association :genre
  end
end
