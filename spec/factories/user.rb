FactoryBot.define do
  factory :user do
    email { 'email@mail.com' }
    name { 'Riczi' }
    password { 'password' }

    trait :other_user do
      email { 'other_user@mail.com' }
    end
  end
end
