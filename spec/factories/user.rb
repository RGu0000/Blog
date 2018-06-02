FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:email) { |n| "email#{n}@mail.com" }
    password 'password'

    trait :other_user do
      email { 'other_user@mail.com' }
    end

    trait :admin do
      admin { true }
    end
  end
end
