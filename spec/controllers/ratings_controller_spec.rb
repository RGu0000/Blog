require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:tag) { create(:tag, :with_1_article_and_user) }
  let(:article) { Article.first }

  context 'user signed in' do
    before { sign_in(user) }

    describe 'POST #create' do
      subject do
        post :create,
          params: {
                    article_id: Article.first.id,
                    rating: { rate: 5.5 }
                  }
      end

      it { expect{subject}.to change{Rating.count}.from(0).to(1) }
      it { should redirect_to(article_path(article)) }
    end

    describe 'PATCH #update' do
      let!(:rating) { create(:rating, author_id: user.id, article_id: Article.first.id, rate: 1) }

      subject { patch :update, params: { article_id: Article.first.id, rating: {rate: 2}, id: Rating.first.id } }

      it { expect{subject}.to change{article.ratings.first.rate}.from(1.0).to(2.0) }
      it { should redirect_to(article_path(article)) }
    end
  end
end
