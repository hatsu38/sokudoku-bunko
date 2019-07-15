# frozen_string_literal: true

FactoryBot.define do
  factory :ranking do
    sequence(:rank) { |n| n }

    association :book
  end
end
