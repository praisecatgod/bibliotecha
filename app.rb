require 'sinatra'
require 'rack-flash'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

require 'json'
require 'require_all'
require 'sinatra/activerecord'
require 'bcrypt'
require 'httparty'
require 'rufus-scheduler'
require 'haml'
require 'thin'
require 'tux'
require 'gon-sinatra'
require_all 'config'
require_all 'models'
require_all 'controllers'

configure do
  #use Rack::Session::Pool
  set :server, 'thin'
  set :bind, '0.0.0.0'
  enable :sessions
  set :session_secret, "My session secret"
  Sinatra::register Gon::Sinatra
end

after { ActiveRecord::Base.connection.close }

not_found do
  status 404
  haml :error
end

get "/403" do
  haml :error
end

get '/' do
  @user = session[:current_user]
  @books_new = Book.order(:created_at).take(4)
  @books_popular = Book.joins(:rentals)
                  .select("books.*, count(rentals.id) as rental_count")
                  .order("rental_count DESC").group("books.id").take(4)
  @books = Book.all
  @rentals = Rental.where(is_active: true)

  gon.books = @books
  gon.rentals = @rentals
  haml :home
end

get '/about' do
  @user = session[:current_user]
  haml :'static/about'
end

get '/help' do
  @user = session[:current_user]
  haml :'static/help'
end
