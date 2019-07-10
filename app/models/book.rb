# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :txt_file, presence: true
  validates :bookid, presence: true, uniqueness: true

  belongs_to :author
  has_one :rakuten_book_info

  scope :recent, -> (count) { order(id: :desc).limit(count) }
  scope :efficiency_list, -> { select('id', 'title', 'author_id').includes(:author, :rakuten_book_info) }

  def self.search(search)
    if search
      self.where('title like ?', "%#{search}%").efficiency_list.recent(30)
    else
      self.limit(30).efficiency_list.recent(30)
    end
  end
end
