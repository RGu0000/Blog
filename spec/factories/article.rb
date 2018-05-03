FactoryBot.define do
  factory :article do
    author_id { user }
    title { 'Test - title' }
    body { 'Test - body' }
  end
end
