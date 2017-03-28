# TODO: check for admin

get "/admin/genres" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end

  @genres = Genre.all
  haml :'admin/adminGenres'
end

post "/admin/genres" do
  @user = session[:current_user]
  #ghi the following 3 lines were not here ghi
  if !@user || !@user.is_admin
    haml :error
  end
  ###############################################

  genre = Genre.create(genre_name: params[:genre_name])
  if genre
    redirect "/admin/genres"
  else
    redirect "/403"
  end
end

put "/admin/genres" do
  #ghi the following 4 lines were not here ghi
  @user = session[:current_user]
  if !@user || !@user.is_admin
    haml :error
  end
  ###############################################

  genre = Genre.find(params[:genre_id])
  if !genre
    redirect "/403"
  elsif genre.genre_name == params[:genre_name]
    redirect "/admin/genres"
  else
    genre.update(genre_name: params[:genre_name])
    redirect "/admin/genres"
  end
end

delete "/admin/genres" do
  #ghi the following 4 lines were not here ghi
  @user = session[:current_user]
  if !@user || !@user.is_admin
    haml :error
  end
  ###############################################
  genre = Genre.find(params[:genre_id])
  if !genre
    redirect "/403"
  else
    genre.destroy()
    redirect "/admin/genres"
  end
end
