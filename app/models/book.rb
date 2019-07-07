# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :txt_file, presence: true
  validates :bookid, presence: true, uniqueness: true

  belongs_to :author
  has_one :rakuten_book_info
end
