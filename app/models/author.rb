# frozen_string_literal: true

class Author < ApplicationRecord
  validates :name, presence: true
  validates :authorid, presence: true, uniqueness: true
  has_many :books, dependent: :destroy

  scope :recent, ->(count) { order(id: :desc).limit(count) }

  def self.search(search)
    if search
      where('name like ?', "%#{search}%").recent(30)
    else
      recent(30)
    end
  end

  def take_books(num)
    books.includes(:rakuten_book_info).select(:id, :title, :impressions_count)
      .order(impressions_count: :desc).order('rakuten_book_infos.medium_image_url desc').take(num)
  end
end
