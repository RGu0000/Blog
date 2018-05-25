FactoryBot.define do
  factory :bookmark do
    user_id { user }
    article_id { article }
  end
end
