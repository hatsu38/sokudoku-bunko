# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@email.com" }
    sequence(:password) { |n| "password#{n}" }
    admin { true }
  end
end
