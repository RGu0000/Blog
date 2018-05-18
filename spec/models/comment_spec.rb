require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'basic validations' do
    it { should belong_to(:author) }
    it { should belong_to(:article) }
    it { should belong_to(:parent) }
    it { should have_many(:children) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(8).is_at_most(256) }
    it { is_expected.to be_a_closure_tree }
  end
end
