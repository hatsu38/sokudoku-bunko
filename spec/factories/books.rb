# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Title_#{n}" }
    sequence(:txt_file) { |n| "txt_file_#{n}" }
    published { Date.today }
    sequence(:zip_url) { |n| "https://example.com/#{n}" }
    sequence(:bookid) { |n| n }
    association :author

    after(:create) do |book|
      create(:rakuten_book_info, book: book)
    end
    after(:create) do |book|
      create(:ranking, book: book)
    end
  end
end
