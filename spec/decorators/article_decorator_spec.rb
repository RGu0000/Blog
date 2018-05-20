require 'rails_helper'

RSpec.describe ArticleDecorator do
  let!(:tag) { create(:tag, :with_1_article_and_user) }
  let(:article) { tag.articles.first }

  describe '#formatted_created_at' do
    before { article.created_at = DateTime.new(2018, 5, 20, 20, 35, 0) }
    it { expect(article.decorate.formatted_created_at).to eq('20.05.2018 at 20:35') }
  end
end
