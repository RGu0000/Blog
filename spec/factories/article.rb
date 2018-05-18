FactoryBot.define do
  factory :article do
    author_id { user }
    title { 'Test - title' }
    body { 'Test - body' }

    trait :with_comments do
      after(:create) do |article|
        create_list :comment, 5, article_id: article.id, author_id: article.author_id
      end
    end
  end
end
