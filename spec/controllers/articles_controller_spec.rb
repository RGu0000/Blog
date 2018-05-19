require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let(:tags_string) { 'test tag' }
  let!(:article) { create(:article, :with_comments, tags: [tag], author_id: user.id) }

  let(:article_form) do
    instance_double(ArticleForm,
      title: 'title',
      body: 'body',
      model_name: ActiveModel::Name.new(Article),
      to_key: nil,
      to_param: nil,
      all_tags: 'test')
  end

  let(:form_params) do
    {
      article_form:
      {
        title: 'Article title',
        body: 'Article body',
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

    describe 'GET articles#show' do
      subject! { get :show, params: { id: Article.first.id } }

      it { expect(subject.status).to eq(200) }
      it { expect(assigns[:article].comments.count).to eq(Comment.count) }
    end

    describe 'POST artictles#create' do
      subject { post :create, params: form_params }
      context 'with valid params' do

        before do
          expect(ArticleForm).to receive(:new).and_return(article_form)
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article_form]))
                                                .and_return(true)
          allow(article_form).to receive(:article) { article }
        end

        it 'check repsonse status' do
          subject
          expect(response.status).to eq(302)
        end
        it { expect(subject).to redirect_to(article_path(article)) }
      end

      context 'with invalidvalid params' do
        before do
          expect(ArticleForm).to receive(:new).and_return(article_form)
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article_form]))
                                                .and_return(false)
          allow(article_form).to receive(:article) { article }
        end

        it 'check rendered partial' do
          subject
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PATCH artictles#update' do
      subject { patch :update, id: article.id, params: form_params }

      context 'with valid params' do
        before do
          expect(ArticleForm).to receive(:new).and_return(article_form)
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article_form]))
                                                .and_return(true)
          allow(article_form).to receive(:article) { article }
        end

        it 'check repsonse status' do
          subject
          expect(response.status).to eq(302)
        end
        it { expect(subject).to redirect_to(article_path(article)) }
      end

      # context 'with invalidvalid params' do
      #   before do
      #     expect(ArticleForm).to receive(:new).and_return(article_form)
      #     expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article_form]))
      #                                           .and_return(false)
      #     allow(article_form).to receive(:article) { article }
      #   end
      #
      #   it 'check rendered partial' do
      #     subject
      #     expect(response).to render_template(:new)
      #   end
      # end

    end



  end
end
