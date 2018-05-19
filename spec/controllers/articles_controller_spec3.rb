require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let(:tags_string) { 'test tag' }
  let!(:article) { create(:article, :with_comments, tags: [tag], author_id: user.id) }


  context 'user logged in' do
    before { sign_in(user) }

    describe 'POST artictles#create' do
      let(:article_form) { instance_double(ArticleForm) }
      let(:form_params) do
        {
          article_form:
          {
            title: 'title',
            body: 'body',
            tags_string: tags_string
          }
        }
      end

      context 'user adds valid article' do
        it 'redirects to new article', :aggregate_failures do
          expect(ArticleForm).to receive(:new).and_return(article_form)
          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article_form]))
                                                .and_return(true)
          allow(article_form).to receive(:article) { article }

          post :create, params: form_params
          expect(response).to redirect_to(article)
        end
      end

      context 'user adds invalid article' do
        it 'renders new form', :aggregate_failures do
          expect(ArticleForm).to receive(:new).and_return(article_form)
          allow(article_form).to receive(:article) { article }

          expect(article_form).to receive(:save).with(hash_including(:author_id, form_params[:article_form]))
                                                .and_return(false)

          post :create, params: form_params
          expect(response).to render_template(:new)
        end
      end

      # context 'user adds invalid article' do
      #   let(:title) { '' }
      #   let(:body) { 'valid body' }
      #
      #   it { expect { subject }.to change { Article.count }.by(0) }
      #   it { should render_template 'articles/new' }
      # end
    end
  end
end
