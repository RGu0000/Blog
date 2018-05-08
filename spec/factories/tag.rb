FactoryBot.define do
  factory :tag do
    name { 'random tag' }

    trait :orphan_tag do
      name { 'orphan_tag' }
    end

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
  end
end
