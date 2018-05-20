require 'rails_helper'

RSpec.describe TagServices::OrphanTagDestroyer do
  describe '#call' do
    subject { described_class.call }

    context 'orphan tag detected and destroyed after deleting article' do
      let!(:tag) { create(:tag, :with_1_article_and_user) }
      before { Article.first.destroy }
      it { expect { subject }.to change { Tag.count }.by(-1) }
    end

    context 'no orphan tag detected nor destroyed after deleting article' do
      let!(:tag) { create(:tag, :with_2_articles_and_user) }
      before { Article.first.destroy }
      it { expect { subject }.to change { Tag.count }.by(0) }
    end
  end
end
