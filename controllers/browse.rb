
get "/browse" do
  @user = session[:current_user]
  sort = params[:sort].to_i

  @books = Book.all

  if sort==0
    @books = @books.order(:created_at)
  elsif sort==1
    @books = Book.joins(:rentals)
    .select("books.*, count(rentals.id) as rental_count")
    .order("rental_count DESC").group("books.id")
  elsif sort==2
    @books = @books.order(:title)
  elsif sort==3
    @books = @books.order(:title).reverse
  end

  @authors = Author.all
  @authors = @authors.sort_by { |a| a.author_name}
  @genres = Genre.all.sort_by { |g| g.genre_name}
  @rentals = Rental.where(is_active: true)

  gon.authors = @authors
  gon.books = @books
  gon.genres = @genres
  gon.rentals = @rentals

  haml :browse
end