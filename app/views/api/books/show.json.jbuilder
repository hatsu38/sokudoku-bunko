# frozen_string_literal: true

json.title @book.title
json.set! :words do
  json.array! @words.each_with_index.to_a do |word, index|
    json.id index
    json.text word.surface
  end
end
