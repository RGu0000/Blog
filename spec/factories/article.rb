FactoryBot.define do
  factory :article do
    author_id { user }
    title { 'Test - title' }
    body { 'Test - body' }

    trait :with_tag do
      after(:create) do |article|
        create :tag, name: 'test_tag', article: article
      end
    end
  end
end
