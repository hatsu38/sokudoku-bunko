# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RakutenBookInfo, type: :model do
  describe '.create' do
    it '生成できる' do
      expect(create(:rakuten_book_info).id).to be_present
    end
  end

  describe 'validation' do
    it 'validationが効いてること' do
      expect(create(:rakuten_book_info)).to be_valid
    end
  end

  describe 'Association' do
    let(:rakuten_book_info) { create(:rakuten_book_info) }
    it 'is belons_to Author' do
      expect(rakuten_book_info.book).to be_present
    end
  end
end
