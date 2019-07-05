# frozen_string_literal: true

json.set! :words do
  json.array! @words do |word|
    json.text word.surface
  end
end
