require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let!(:article) { create(:article, tags: [tag], author_id: user.id) }

  context 'user logged in' do
    before { sign_in(user) }

    describe 'GET articles#index' do
      subject { get :index }

      it { expect(subject.status).to eq(200) }
      it { expect(subject.body.to_s).to match(article.title) }
    end

    describe 'GET articles#show' do
      subject { get :show, params: { id: Article.first.id } }

      it { expect(subject.status).to eq(200) }
    end

    describe 'GET articles#new' do
      subject { get :new }

      it 'creates new instance of Article' do
        subject
        expect(assigns[:article]).to be_a(Article)
      end

      it { expect(subject.status).to eq(200) }
    end

    describe 'POST artictles#create' do
      subject do
        post :create, params: {
          article:
          {
            title: title,
            body: body,
            tag_list: tag
          }
        }
      end

      context 'user adds valid article' do
        let(:title) { 'valid title' }
        let(:body) { 'valid body' }

        it { expect { subject }.to change { Article.count }.by(1) }

        it 'redirects to new article' do
          subject
          expect(response).to redirect_to assigns[:article]
        end
      end

      context 'user adds invalid article' do
        let(:title) { '' }
        let(:body) { 'valid body' }

        it { expect { subject }.to change { Article.count }.by(0) }
        it { should render_template 'articles/new' }
      end
    end

    describe 'PATCH articles#update' do
      subject do
        patch :update, params: {
          article:
          {
            title: updated_title
          }, id: article.id
        }
      end

      context 'user uses valid data' do
        let(:updated_title) { 'Updated title' }

        it 'updates the title' do
          subject
          expect(Article.last.title).to eq(updated_title)
        end

        it { expect(subject).to redirect_to(article_path(article)) }
      end

      context 'user uses invalid data' do
        let(:updated_title) { '' }
        it 'fails to update the title' do
          subject
          expect(Article.last.title).not_to eq(updated_title)
        end
        it { should render_template 'articles/edit' }
      end
    end

    describe 'DELETE articles#destroy' do
      subject do
        delete :destroy, params: {
          id: id
        }
      end

      context 'user deletes his article' do
        let!(:id) { article.id }
        it { expect { subject }.to change { Article.count }.by(-1) }
        it { should redirect_to(articles_path) }
      end

      context 'user deletes not his article' do
        let!(:another_user) { create(:user, :other_user) }
        let!(:another_article) { create(:article, tags: [tag], author_id: another_user.id) }
        let!(:id) { another_article.id }

        it { expect { subject }.to change { Article.count }.by(0) }
        it { should redirect_to(article_path(another_article)) }
      end

      # context 'deleting fails ---???????????????????????????????????????' do
      #   let!(:another_user) { create(:user, :other_user) }
      #   let!(:another_article) { create(:article, tags: [tag], author_id: another_user.id) }
      #   let!(:id) { 10 }
      #
      #   it { expect { subject }.to change { Article.count }.by(0) }
      #   it { should redirect_to(article_path(another_article)) }
      # end
    end
  end

  context 'user not logged in' do
    describe 'POST articles#create' do
      subject do
        post :create, params: {
          article:
          {
            title: title,
            body: body,
            tag_list: tag
          }
        }
      end

      context 'user tries to add the article' do
        let(:title) { 'valid title' }
        let(:body) { 'valid body' }

        it { expect { subject }.to change { Article.count }.by(0) }
        it { should redirect_to '/users/sign_in' }
      end
    end

    describe 'DELETE articles#destroy' do
      subject do
        delete :destroy, params: {
          id: id
        }
      end

      context 'user tries to delete the article' do
        let!(:id) { article.id }

        it { expect { subject }.to change { Article.count }.by(0) }
        it { should redirect_to '/users/sign_in' }
      end
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
