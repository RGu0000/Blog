require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'basic validations' do
    it { should belong_to(:author) }
    it { should have_many(:taggings) }
    it { should have_many(:tags) }
    it { should have_many(:comments) }
  end
end
