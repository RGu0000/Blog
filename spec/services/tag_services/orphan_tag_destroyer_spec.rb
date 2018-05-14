require 'rails_helper'

RSpec.describe TagServices::OrphanTagDestroyer do
  subject { described_class.call }

  describe '#call' do
    context 'orphan tag detected after deleting article' do
      let!(:tag) { create(:tag, :with_1_article_and_user) }
      before { Article.first.destroy }
      it { expect { subject }.to change { Tag.count }.by(-1) }
    end

    context 'no orphan tag detected after deleting article' do
      let!(:tag) { create(:tag, :with_2_articles_and_user) }
      before { Article.first.destroy }
      it { expect { subject }.to change { Tag.count }.by(0) }
    end
  end
end
