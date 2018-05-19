require 'rails_helper'

RSpec.describe TagsQuery do
  describe 'self.sort_by_occurances' do
    subject { described_class.sort_by_occurances }

    let!(:tag) { create(:tag, :with_10_articles_and_user) }
    let!(:tag2) { create(:tag, :with_2_articles_and_user) }
    let!(:tag3) { create(:tag, :with_1_article_and_user) }
    let!(:tag4) { create(:tag) }

    context 'First tag has 10 articles' do
      it { expect(subject.first.tags_count).to eq(10) }
    end

    context 'Second tag has 2 articles' do
      it { expect(subject.second.tags_count).to eq(2) }
    end

    context 'Third tag has 1 articles' do
      it { expect(subject.third.tags_count).to eq(1) }
    end

    context 'Tag with no articles not in the list' do
      it { expect(subject.last.tags_count).not_to eq(0) }
    end
  end
end
