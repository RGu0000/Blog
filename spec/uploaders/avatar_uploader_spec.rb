require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { double('user', id: 1) }
  let(:uploader) { AvatarUploader.new(user, :avatar) }

  before do
    described_class.enable_processing = true
    File.open('app/assets/images/fallback/missing-avatar.png') { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 250 by 250 pixels" do
      expect(uploader.thumb).to have_dimensions(250, 250)
    end
  end


end
