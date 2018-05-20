require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  let!(:tag) { create(:tag, :with_2_articles_and_user) }
  let(:user) { Tag.first.articles.first.author }

  describe 'GET #index' do
    subject { get :index }

    it { expect(subject.status).to eq(200) }
    it { expect(subject.body.to_s).to match(user.email) }
  end

  describe 'GET #show' do
    subject! { get :show, params: { id: User.first.id } }

    it { expect(subject.status).to eq(200) }
    it { expect(assigns[:user].object.email).to eq(user.email) }
    it { expect(assigns[:user].name).to eq(user.name) }
    it { expect(assigns[:user].displayed_name).to eq(user.name) }
  end
end
