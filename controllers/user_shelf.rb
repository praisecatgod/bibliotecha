post '/rent' do
  user = session[:current_user]
  if !user
    redirect "/403"
  end
  book = Book.find(params[:book_id])
  if !book
    redirect "/403"
  end
  exist = Rental.where(book_id: book.id, is_active: true).count
  if exist > 0
    redirect "/"
  end
  # TODO: see if book is already checked out
  rental = Rental.new
  rental = Rental.create(user_id: user.id, book_id: book.id, is_active: true )
  if rental
    redirect "/shelf"
  end
end

get "/shelf" do
  @user = session[:current_user]
  if !@user
    redirect "/403"
  end
  @rentals = Rental.where(user_id: @user.id, is_active: true)
  @history = Rental.where(user_id: @user.id, is_active: false).order('updated_at DESC')
  @books = Book.all
  @all_rentals = Rental.where(is_active: true)
  gon.books = @books
  gon.rentals = @all_rentals
  haml :'user/shelf'
end

post "/return" do
  user = session[:current_user]
  if !user
    redirect "/403"
  end
  rental = Rental.find(params[:rental_id])
  if !rental
    redirect "/403"
  end
  rental.is_active = false
  rental.save
  redirect "/shelf"
end

post "/download" do
  getFact
end

def getFact
  url = URI.parse('http://catfacts-api.appspot.com/api/facts')
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) {|http|
  http.request(req)}
  facts = res.body
  facts = JSON.parse(facts)
  fact = "CAT FACT: "+facts['facts'].to_s[2..-3]
  return fact
end
