# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '.create' do
    it '生成できる' do
      expect(create(:book).id).to be_present
    end
  end

  describe 'validation' do
    it 'validationが効いてること' do
      expect(create(:book)).to be_valid
    end

    describe 'title is nill' do
      let(:book) { build(:book, title: '') }
      it 'is not be valid without title' do
        expect(book).to be_invalid
      end
    end
  end

  describe 'Association' do
    let(:book) { create(:book) }
    it 'is belons_to Author' do
      expect(book.author).to be_present
    end

    it 'is has_on RakutenBookInfo' do
      expect(book.rakuten_book_info).to be_present
    end
  end
end
