require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end
end
