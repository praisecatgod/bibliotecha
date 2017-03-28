get "/admin/books" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end

  @books = Book.all
  @book_authors = BookAuthor.all
  @book_genres = BookGenre.all
  @authors = Author.all
  @genres = Genre.all

  @active_rentals = Rental.where(is_active: true).order('created_at DESC')
  @old_rentals = Rental.where(is_active: false).order('updated_at DESC')
  @users = User.all
  @book_author = BookAuthor.all
  @book_genre = BookGenre.all

  gon.authors = @authors
  gon.books = @books
  gon.genres = @genres
  gon.book_author = @book_author
  gon.book_genre = @book_genre
  gon.active_rentals = @active_rentals
  gon.old_rentals = @old_rentals 
  gon.users = @users
  haml :'admin/adminBooks'
  #end
end

post "/admin/books" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  book = Book.create(isbn: params[:isbn].to_i,
    title: params[:title],
    summary: params[:summary])
  params[:authors].each do |a|
    book_author = BookAuthor.create(
      book_id: book.id,
      author_id: a)
  end
  params[:genres].each do |g|
    book_genre = BookGenre.create(
      book_id: book.id,
      genre_id: g)
  end
  redirect "/admin/books"
end

put "/admin/books" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  book = Book.find(params[:book_id])
  book.update(isbn: params[:isbn].to_i,
    title: params[:title],
    summary: params[:summary])

  book_authors = BookAuthor.where(book_id: book.id)
  book_authors.each do |ba|
    ba.delete()
  end

  book_genres = BookGenre.where(book_id: book.id)
  book_genres.each do |bg|
    bg.delete()
  end

params[:authors].each do |a|
  book_author = BookAuthor.create(
      book_id: book.id,
      author_id: a)
  end
params[:genres].each do |g|
  book_genre = BookGenre.create(
      book_id: book.id,
      genre_id: g)
end

redirect "/admin/books"

end

delete "/admin/books" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  book = Book.find(params[:book_id])
  if !book
    redirect "/403"
  else
    book.destroy()
    redirect "/admin/books"
  end
end
