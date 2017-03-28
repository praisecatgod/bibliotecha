# TODO: check for admin

get "/admin/authors" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  @authors = Author.all
  haml :'admin/adminAuthors'
end

post "/admin/authors" do
  @user = session[:current_user]
  
  if !@user || !@user.is_admin
    redirect "/403"
  end

  author = Author.create(author_name: params[:author_name])
  if author
    redirect "/admin/authors"
  else
    redirect "/403"
  end
end

put "/admin/authors" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end

  author = Author.find(params[:author_id])
  if !author
    redirect "/403"
  elsif author.author_name == params[:author_name]
    redirect "/admin/authors"
  else
    author.update(author_name: params[:author_name])
    redirect "/admin/authors"
  end
end

delete "/admin/authors" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end

  author = Author.find(params[:author_id])
  if !author
    redirect "/403"
  else
    author.destroy()
    redirect "/admin/authors"
  end
end
