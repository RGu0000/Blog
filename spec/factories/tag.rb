FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag#{n}" }

    trait :with_1_article_and_user do
      after(:create) do |tag|
        create :user
        create :article, tags: [tag], author_id: User.first.id
      end
    end

    trait :with_2_articles_and_user do
      after(:create) do |tag|
        create :user
        create_list :article, 2, tags: [tag], author_id: User.first.id
      end
    end

    trait :with_10_articles_and_user do
      after(:create) do |tag|
        create :user
        create_list :article, 10, tags: [tag], author_id: User.first.id
      end
    end
  end
end
