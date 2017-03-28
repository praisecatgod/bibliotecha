# TODO: check for admin

get "/admin/users" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  @users = User.all
  @books = Book.all
  @active_rentals = Rental.where(is_active: true).order('created_at DESC')
  @old_rentals = Rental.where(is_active: false).order('updated_at DESC')

  gon.books = @books
  gon.active_rentals = @active_rentals
  gon.old_rentals = @old_rentals 
  haml :'admin/adminUsers'
end

post "/admin/users" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end

  user = User.create(library_card: params[:library_card],
    email: params[:email],
    password: params[:password],
    password_confirmation: params[:password_confirm],
    is_admin: params[:is_admin])

  if user
    redirect "/admin/users"
  else
    redirect "/403"
  end

end

put "/admin/users" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end

  user = User.find(params[:user_id])
  if !user
    redirect "/403"
  #elsif user.library_card == params[:library_card]
    #redirect "/admin/users"
  #elsif user.email == params[:email]
    #redirect "/admin/users"
  else
    if params[:change_password]
      user.update(library_card: params[:library_card],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirm],
        is_admin: params[:is_admin])
      redirect "/admin/users"
    else
      user.update(library_card: params[:library_card],
      email: params[:email],
      is_admin: params[:is_admin])
      redirect "/admin/users"
    end
  end
end

get "/test/:password" do
  params[:password]
end

delete "/admin/users" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  user = User.find(params[:user_id])
  if !user
    "can not find user"
  else
    user.destroy()
    redirect "/admin/users"
  end
end
