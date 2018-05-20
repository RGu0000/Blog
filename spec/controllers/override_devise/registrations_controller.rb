require 'rails_helper'

RSpec.describe OverrideDevise::RegistrationsController, type: :controller do
  render_views

  let!(:user) { create(:user) }

  context 'user logged in' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in(user)
    end

    describe 'DELETE override_devise/registrations#destroy' do
      subject { delete :destroy }

      it { expect { subject }.to change { User.count }.by(-1) }
      it 'checks if services are called' do
        expect(UserServices::UserAndAssociationsDestroyer).to receive(:call).with(user.id)
        expect(TagServices::OrphanTagDestroyer).to receive(:call)
        subject
      end
    end
  end
end
