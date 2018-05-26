require 'rails_helper'

RSpec.describe ArticleForm do
  let!(:tag1) { create(:tag, :with_1_article_and_user) }
  let!(:tag2) { create(:tag, :with_1_article_and_user) }
  let(:article) { tag1.articles.first }
  let(:new_form) { described_class.new }
  let(:edit_form) { described_class.new(article) }
  let(:save_form) { new_form.save(article_params) }

  let(:title) { "valid title" }
  let(:body) { "valid body" }
  let(:tags_string) { "valid tags string" }

  let(:article_params) do
    {
    title: title,
    body: body,
    tags_string: tags_string,
    author_id: User.first.id
    }
  end

  describe '#initialize' do
    subject { new_form }

    it { expect(subject.article).not_to be_nil }
  end

  describe '#save' do
    subject { new_form.save(article_params) }

    context 'with valid params' do
      it { expect(subject).to eq(true) }
      it { expect { subject }.to change{ Article.count }.by(1) }
      it { expect { subject }.to change{ Tag.count }.by(tags_string.split.count) }
    end

    context 'with empty title' do
      let(:title) { '' }
      it { expect(subject).to eq(false) }
    end

    context 'with empty body' do
      let(:body) { '' }
      it { expect(subject).to eq(false) }
    end

    context 'with empty tags' do
      let(:tags_string) { '' }
      it { expect(subject).to eq(false) }
    end

    context 'with forbidden word in title' do
      let(:title) { 'wwwwwww noob' }
      it { expect(subject).to eq(false) }
    end

    context 'with forbidden word in body' do
      let(:body) { 'wwwwwww noob' }
      it { expect(subject).to eq(false) }
    end

    context 'with 2 tags - 1 already existing' do
      let(:tags_string) { "#{tag1.name} uniquetag" }
      it { expect{subject}.to change{ Tag.count }.by(1) }
    end
  end

  describe '#all_tags' do
    context 'tags present' do
      before { article.tags << tag2 }
      subject { edit_form.all_tags }

      it { is_expected.to eq("#{tag1.name}, #{tag2.name}") }
    end

    context 'tags empty' do
      let(:article_tags_empty) { build_stubbed(:article, author_id: User.first.id) }

      subject { described_class.new(article_tags_empty).all_tags }

      it { is_expected.to eq('') }
    end
  end



end
