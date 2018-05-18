require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'checking basic validations and associations' do
    it { should have_many(:taggings) }
    it { should have_many(:articles) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should allow_value('Name').for(:name) }
    it { should_not allow_value('Inv alid').for(:name) }
  end

  describe '.to_s' do
    before { create(:tag, :with_1_article_and_user) }

    it { expect(Tag.first.to_s).to eq(Tag.first.name) }
  end
end
