# frozen_string_literal: true

json.title @book.title
json.set! :words do
  json.array! @words do |word|
    json.text word.surface
  end
end
