FactoryBot.define do
  factory :user do
    uuid { SecureRandom.uuid }
    email { Faker::Internet.email }
    password { "password" }
  end
end
