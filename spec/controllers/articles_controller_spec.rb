require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let(:tags_string) { 'test tag' }
  let!(:article) { create(:article, :with_comments, tags: [tag], author_id: user.id) }
  let(:article_form) { ArticleForm.new }
  let(:form_params) do
    {
      article:
      {
        title: article.title,
        body: article.body,
        tags_string: tags_string
      }
    }
  end

  context 'user logged in' do
    before { sign_in(user) }

    describe 'GET articles#index' do
      subject { get :index }

      it { expect(subject.status).to eq(200) }
      it { expect(subject.body.to_s).to match(article.title) }
    end

    describe 'GET articles#new' do
      subject! { get :new }

      it { expect(assigns[:article_form]).to be_a(ArticleForm) }
      it { expect(subject.status).to eq(200) }
    end

    describe 'GET articles#show' do
      subject! { get :show, params: { id: Article.first.id } }

      it { expect(subject.status).to eq(200) }
      it { expect(assigns[:article].comments.count).to eq(Comment.count) }
    end

    describe 'POST artictles#create' do
      before do
        allow(ArticleForm).to receive(:new).and_return(article_form)
        allow(article_form).to receive(:article) { article }
      end

      subject { post :create, params: form_params }

      context 'with valid params' do
        it 'returns a successful response', :aggregate_failures do
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article]))
                                                .and_return(true)
          subject
          expect(response.status).to eq(302)
          expect(subject).to redirect_to(article_path(article))
        end
      end

      context 'with invalid params' do
        it 'returns a unsuccessful response', :aggregate_failures do
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article]))
                                                .and_return(false)
          subject
          expect(subject).to render_template(:new)
        end
      end
    end

    describe 'GET articles#edit' do
      subject! { get :edit, params: { id: Article.first.id } }

      it { expect(assigns[:article_form]).to be_a(ArticleForm) }
      it { expect(assigns[:article_form].article.id).to eq(article.id) }

      it { expect(subject.status).to eq(200) }
    end

    describe 'PATCH artictles#update' do
      before do
        allow(ArticleForm).to receive(:new).and_return(article_form)
        allow(article_form).to receive(:article) { article }
      end

      subject { patch :update, params: form_params }

      let(:form_params) do
        {
          id: article.id,
          article:
          {
            title: article.title,
            body: article.body,
            tags_string: tags_string
          }
        }
      end

      context 'with valid params' do
        it 'returns a successful response', :aggregate_failures do
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article]))
                                                .and_return(true)
          expect(TagServices::OrphanTagDestroyer).to receive(:call)
          subject
          expect(response.status).to eq(302)
          expect(subject).to redirect_to(article_path(article))
        end
      end

      context 'with invalid params' do
        it 'returns a unsuccessful response', :aggregate_failures do
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article]))
                                                .and_return(false)
          subject
          expect(subject).to render_template(:edit)
        end
      end

      describe 'DELETE articles#destroy' do
        subject { delete :destroy, params: { id: id } }

        context 'user deletes his article' do
          let(:id) { article.id }

          it { expect { subject }.to change { Article.count }.by(-1) }
          it { should redirect_to(articles_path) }
        end

        context 'user deletes not his article' do
          let!(:another_user) { create(:user, :other_user) }
          let!(:another_article) { create(:article, tags: [tag], author_id: another_user.id) }
          let(:id) { another_article.id }

          it { expect { subject }.to change { Article.count }.by(0) }
          it { should redirect_to(article_path(another_article)) }
        end

        context 'test' do
          let(:id) { article.id }

          before { allow_any_instance_of(Article).to receive(:destroy).and_return(false) }

          it 'article.destroy returns fails' do
            expect { subject }.to change { Article.count }.by(0)
            should redirect_to(article_path(assigns[:article]))
          end
        end
      end
    end
  end

  context 'user not logged in' do
    describe 'POST articles#create' do
      subject do
        post :create, params: {
          article:
          {
            title: article.title,
            body: article.body,
            tags_string: tags_string
          }
        }
      end

      context 'user tries to add the article' do
        it { expect { subject }.to change { Article.count }.by(0) }
        it { should redirect_to '/users/sign_in' }
      end
    end

    describe 'DELETE articles#destroy' do
      subject { delete :destroy, params: { id: article.id } }

      context 'user tries to delete the article' do
        let!(:id) { article.id }

        it { expect { subject }.to change { Article.count }.by(0) }
        it { should redirect_to '/users/sign_in' }
      end
    end
  end
end
