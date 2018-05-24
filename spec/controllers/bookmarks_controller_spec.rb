require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:tag) { create(:tag, :with_1_article_and_user) }
  before { sign_in(user) }

  describe 'POST #create' do
    subject do
      post :create, params: { user_id: user.id, article_id: Article.first.id }
    end

    it { expect{subject}.to change{Bookmark.count}.by(1) }
    it { expect(subject.status).to eq(302) }
  end

<<<<<<< HEAD
  describe 'DELETE #destroy' do
=======
  describe 'DEKETE #destroy' do
>>>>>>> 2f045587f0899dd58ddb80c2c656b4049a73a04d
    let!(:bookmark) { create(:bookmark, user_id: user.id, article_id: Article.first.id) }

    subject do
      delete :destroy, params: { article_id: Article.first.id, id: Bookmark.first.id }
    end

    it { expect{ subject }.to change{Bookmark.count}.by(-1) }
    it { expect(subject.status).to eq(302) }
  end
end
