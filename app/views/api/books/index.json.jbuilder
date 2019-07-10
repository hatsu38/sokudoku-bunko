# frozen_string_literal: true

json.set! :books do
  json.array! @books do |book|
    json.extract! book, :id, :title, :author_id
  end
end
