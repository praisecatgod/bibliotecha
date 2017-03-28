class BookGenre < ActiveRecord::Base
  belongs_to :book, :dependent => :destroy
  belongs_to :genre, :dependent => :destroy
end
