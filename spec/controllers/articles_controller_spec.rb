require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  context 'When user logged in' do
    let!(:user) { create(:user) }
    let!(:tag) { create(:tag) }
    let!(:article) { create(:article, tags: [tag], author_id: user.id) }

    describe 'GET #index' do
      subject { get :index }

      it { expect(subject.status).to eq(200) }
      it { expect(subject.body.to_s).to match(article.title) }
    end
  end
end
