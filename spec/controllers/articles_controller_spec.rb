require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  context 'When user logged in' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, author_id: user.id) }
    describe 'GET #index' do
      subject { get :index }

      it { expect(subject.status).to eq(200) }
      it { binding.pry }
    end
  end
end
