require 'rails_helper'

RSpec.describe RatingValidator do
  subject { Validatable.new(rate: rate) }

  shared_examples 'has valid rating' do
    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

  shared_examples 'has invalid rating' do
    it 'should not be valid' do
      expect(subject).not_to be_valid
    end
  end

  context 'with negative rate' do
    let(:rate) { -0.5 }
    it_behaves_like 'has invalid rating'
  end

  context 'with too big rate' do
    let(:rate) { 10.5 }
    it_behaves_like 'has invalid rating'
  end

  context 'with 0' do
    let(:rate) { 0 }
    it_behaves_like 'has valid rating'
  end

  context 'with 0.5' do
    let(:rate) { 0.5 }
    it_behaves_like 'has valid rating'
  end

  context 'with float number indivisible with 0.5' do
    let(:rate) { 0.35 }
    it_behaves_like 'has invalid rating'
  end


end

class Validatable
  include ActiveModel::Validations
  validates_with RatingValidator
  attr_accessor :rate

  def initialize(rate:)
    @rate = rate
  end
end
