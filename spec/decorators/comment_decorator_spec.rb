require 'rails_helper'

RSpec.describe CommentDecorator do
  let!(:tag) { create(:tag, :with_1_article_and_user) }
  let(:comment) { create(:comment, article_id: Article.first.id, author_id: User.first.id) }

  describe '#formatted_created_at' do
    before { comment.created_at = DateTime.new(2018, 5, 20, 20, 35, 0) }
    it { expect(comment.decorate.formatted_created_at).to eq('20.05.2018 at 20:35') }
  end
end
