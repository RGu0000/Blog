require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  context 'When user logged in' do
    let!(:user) { create(:user) }
    let!(:tag) { create(:tag) }
    let!(:article) { create(:article, tags: [tag], author_id: user.id) }

    before { sign_in(user) }

    describe 'GET #index' do
      subject { get :index }

      it { expect(subject.status).to eq(200) }
      it { expect(subject.body.to_s).to match(article.title) }
    end
  end
  #
  #   describe 'POST #create' do
  #     let(:tag) { create(:tag) }
  #     let(:params) do
  #       {
  #         article:
  #         {
  #           title: 'Test title',
  #           body: 'Test body',
  #           tags: [tag],
  #           author_id: 1
  #         }
  #       }
  #     end
  #
  #     subject { post :create, params: params }
  #
  #     before do
  #       allow(HerokuBlogpost::Creator).to receive_message_chain(:new, :call)
  #     end
  #
  #     it 'saves new article to db' do
  #       subject
  #       binding.pry
  #       expect(Article.last.title).to eq('Test title')
  #     end
  #   end
  # end
end
