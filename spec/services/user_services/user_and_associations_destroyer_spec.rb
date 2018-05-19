require 'rails_helper'

RSpec.describe UserServices::UserAndAssociationsDestroyer do
  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let(:tags_string) { 'test tag' }
  let!(:article) { create(:article, :with_comments, tags: [tag], author_id: user.id) }

  describe 'self.call' do
    subject { described_class.call(user.id) }

    context 'associations destroyed' do
      it { expect { subject }.to change { Comment.count }.by(-5) }
      it { expect { subject }.to change { Article.count }.by(-1) }
      it { expect { subject }.to change { Tagging.count }.by(-1) }
    end
  end
end
