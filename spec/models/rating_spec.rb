require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:article) }
  end

  describe 'validation of uniquness' do
    let!(:tag) { create(:tag, :with_1_article_and_user) }
    let!(:rating) do
      create(
        :rating,
        author_id: User.first.id,
        article_id: Article.first.id,
        rate: 2.0
      )
    end
    it { should validate_uniqueness_of(:author_id).scoped_to(:article_id) }
  end
end
