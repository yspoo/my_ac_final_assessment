FactoryBot.define do
  factory :note do
    title "MyString"
    body "MyText"
    association :user

    trait :invalid do
      title nil
    end

  end
end
