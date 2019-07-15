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

    it 'is has_on ranking' do
      expect(book.ranking).to be_present
    end
  end

  describe 'scope' do
    let!(:books) { create_list(:book, 3) }
    describe 'recent' do
      it 'work' do
        expect(Book.recent(3).count).to eq(3)
        expect(Book.recent(1).first).to eq books.last
      end
    end

    describe 'efficiency_list' do
      it 'work' do
        expect(Book.efficiency_list.pluck(:id)).to eq(Book.all.pluck(:id))
        expect(Book.efficiency_list.pluck(:title)).to eq(Book.all.pluck(:title))
        expect(Book.efficiency_list.pluck(:author_id)).to eq(Book.all.pluck(:author_id))
      end
    end
  end

  describe 'method' do
    describe 'search' do
      let!(:books) { create_list(:book, 3) }
      let!(:book) { create(:book, title: '羅生門') }
      context 'exist params' do
        it 'work' do
          expect(Book.search('生').count).to eq(1)
          expect(Book.search('生').first.title).to eq(book.title)
        end
      end

      context 'not exist params' do
        it 'work' do
          expect(Book.search('').count).to eq(Book.all.count)
          expect(Book.search('').first.id).to eq(Book.last.id)
        end
      end
    end
  end
end
