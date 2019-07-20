# frozen_string_literal: true

class Author < ApplicationRecord
  validates :name, presence: true
  validates :authorid, presence: true, uniqueness: true
  has_many :books, dependent: :destroy

  scope :recent, ->(count) { order(id: :desc).limit(count) }

  def self.search(search)
    if search
      self.where('name like ?', "%#{search}%").recent(30)
    else
      self.recent(30)
    end
  end
end
