require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  render_views

  let!(:tag) { create(:tag, :with_1_article_and_user) }

  describe 'GET #index' do
    subject { get :index }

    it { expect(subject.status).to eq(200) }
    it { expect(subject.body.to_s).to match(tag.name) }
  end

  describe 'GET #show_name' do
    subject! { get :show_name, params: { name: Tag.first.name } }

    it { expect(assigns[:tag].name).to eq(tag.name) }
  end
end
