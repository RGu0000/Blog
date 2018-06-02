require 'rails_helper'

RSpec.describe ArticlePolicy do
  describe '#authorized?' do
    let!(:author) { create(:user) }
    let!(:admin) { create(:user, :admin) }
    let!(:viewer) { create(:user) }
    let!(:tag) { create(:tag, :with_1_article) }

    context 'for author' do
      subject { described_class.new(author, Article.first) }
      it { should permit(:authorized) }
    end

    context 'for admin' do
      subject { described_class.new(admin, Article.first) }
      it { should permit(:authorized) }
    end

    context 'for regular viewer' do
      subject { described_class.new(viewer, Article.first) }
      it { should_not permit(:authorized) }
    end

  end
end
