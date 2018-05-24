FactoryBot.define do
  factory :rating do
    author_id { user }
    article_id { article }
    rate { rate }
  end
end
