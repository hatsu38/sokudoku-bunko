# frozen_string_literal: true

FactoryBot.define do
  factory :rakuten_book_info do
    sequence(:price) { |n| n }
    sequence(:affiliate_url) { |n| "https://rakuten/#{n}" }
    sequence(:small_image_url) { |n| "https://rakuten/small_image_#{n}.png" }
    sequence(:medium_image_url) { |n| "https://rakuten/medium_image_#{n}.png" }
    sequence(:caption) { |n| "キャプションが入るよ_#{n}" }

    association :book
  end
end
