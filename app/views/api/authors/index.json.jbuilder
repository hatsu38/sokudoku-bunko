# frozen_string_literal: true

json.set! :authors do
  json.array! @authors do |author|
    json.extract! author, :id, :name, :birthday, :books
  end
end
