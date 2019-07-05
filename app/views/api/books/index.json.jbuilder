# frozen_string_literal: true

json.set! :books do
  json.array! @books do |book|
    json.extract! book, :id, :title, :sentence, :created_at, :updated_at
  end
end
