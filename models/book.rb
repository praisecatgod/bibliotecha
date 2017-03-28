class Book < ActiveRecord::Base
  validates :isbn,
              length: { in: 10..13 },
              numericality: { only_integer: true },
              uniqueness: true
  has_many :book_genres
  has_many :book_authors
  has_many :rentals
  has_many :reservations
end
