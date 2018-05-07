require 'rails_helper'

RSpec.describe HerokuBlogpost::Creator, type: :service do
  let(:body) { double }
  let(:connection) { double }
  let(:req) { double }
  let(:response) { double }
  let(:body) { { 'id' => 'ok' }.to_json }

  subject { described_class.new(body).call }

  before do
    allow(Faraday).to receive(:new) { connection }
    allow(connection).to receive(:post).and_yield(req).and_return(response)
    allow(req).to receive(:body=)
    allow(response).to receive(:body) { body }
  end

  it { is_expected.to eq('ok') }
end
