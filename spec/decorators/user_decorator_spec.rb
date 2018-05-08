require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#displayed_name' do
    let!(:user) { create :user }
    context 'name left empty' do
      before { user.name = '' }

      it { expect(user.decorate.displayed_name).to eq(user.email) }
    end

    context 'name specified' do
      it { expect(user.decorate.displayed_name).to eq(user.name) }
    end
  end
end
