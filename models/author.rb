class Author < ActiveRecord::Base
  has_many :book_authors
end
