require 'rubygems'
require 'fileutils'
require 'json'

@data_format = [".txt"]
@cover_format = [".jpg"]
@authors = []
@books = []

# book
  # overview -> summary
  # title
  # ISBN-13 -> isbn

class Book
  def initialize(title, isbn, summary, book_authors)
    @summary = summary
    @title = title
    @isbn = isbn
    @book_authors = book_authors
  end

  def to_s
    "Title: #{@title}\nAuthors: #{@book_authors}\nISBN: #{@isbn}\nSummary: #{@summary}\n\n"
  end
end

def data(start)
  Dir.foreach(start) do |x|
    path = File.join(start, x)
    if x == "." or x == ".."
      next
    elsif File.directory?(path)
      #puts path + "/" # remove this line if you want; just prints directories
      data(path)
    else
      if @data_format.include? File.extname(x)
        #puts x
        file = File.open(path, "rb")
        contents = file.read
        parsed = JSON.parse(contents)
        book_authors = []
        parsed["authors"].each do |a|
          @authors.push(a)
          book_authors.push(a)
        end
        #puts parsed["details"].first[9..-1]
        @books.push( Book.new(parsed["title"].first, parsed["details"].first[9..-1], parsed["overview"].first, book_authors ) )
        file.close
      #elsif @cover_format.include? File.extname(x)
        #FileUtils.mv(x, '/opt/new/location/your_file')
        #puts path
        #puts File.expand_path("..", Dir.pwd)+'/public/covers/'+x
        #FileUtils.mv(path, File.expand_path("..", Dir.pwd)+'/public/covers/'+x)
      end
    end
  end
end


data(Dir.pwd)
@authors.uniq!.sort!
#puts @authors
#puts @authors.length
puts @books
