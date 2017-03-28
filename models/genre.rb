class Genre < ActiveRecord::Base
  has_many :book_genres
end
