post '/login' do
  json = {message: "no"}
  user = User.where("library_card = ? OR email = ?",
  params[:email],params[:email]).
  first.try(:authenticate, params[:password])
  if user
    session[:current_user] = user
    json[:message] = "yes"
  end
  json.to_json
end

post '/signup' do
  json = {message: "no"}
  user = User.create(library_card: params[:library_card],
  email: params[:email],
  password: params[:password],
  password_confirmation: params[:password_confirm],
  is_admin: false)
  if user
    session[:current_user] = user
    json[:message] = "yes"
  end
  json.to_json
end

get "/signout" do
  puts params.inspect
  session[:current_user] = nil
  redirect '/'
end
