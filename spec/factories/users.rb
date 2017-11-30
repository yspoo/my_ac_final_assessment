FactoryBot.define do
  factory :user do
    sequence :username { |n| "username#{n}" }
    sequence :email { |n| "user#{n}@example.com" }
    password "password123"
  end
end
