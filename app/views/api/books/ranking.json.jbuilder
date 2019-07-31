# frozen_string_literal: true

json.set! :books do
  json.array! @books do |book|
    json.partial! book
  end
end
