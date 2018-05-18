FactoryBot.define do
  factory :comment do
    author_id { user }
    body { 'Comment body' }
    article_id { article }
    parent_id { nil }
  end
end
