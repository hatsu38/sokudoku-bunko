# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "Name_#{n}" }
    birthday { Date.today }
    sequence(:authorid) { |n| n }

    after(:create) do |author|
      create_list(:book, 3, author: author)
    end
  end
end
