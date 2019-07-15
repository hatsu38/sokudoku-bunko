# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ranking, type: :model do
  describe '.create' do
    it '生成できる' do
      expect(create(:ranking).id).to be_present
    end
  end

  describe 'validation' do
    it 'validationが効いてること' do
      expect(create(:ranking)).to be_valid
    end
  end

  describe 'Association' do
    let(:ranking) { create(:ranking) }
    it 'is belons_to Author' do
      expect(ranking.book).to be_present
    end
  end
end
