# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe '.create' do
    it '生成できる' do
      expect(create(:author).id).to be_present
    end
  end

  describe 'validation' do
    it 'validationが効いてること' do
      expect(create(:author)).to be_valid
    end

    describe 'name is nill' do
      let(:author) { build(:author, name: '') }
      it 'is not be valid without name' do
        expect(author).to be_invalid
      end
    end
  end

  describe 'Association'
  let(:author) { create(:author) }
  it 'is belons_to Author' do
    expect(author.books.count).to eq 3
  end
end
