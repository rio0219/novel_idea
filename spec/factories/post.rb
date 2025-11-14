FactoryBot.define do
  factory :post do
    uuid { SecureRandom.uuid }
    content { "テスト投稿" }
    association :user
    association :genre
  end
end
