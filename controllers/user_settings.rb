get "/settings" do
  @user = session[:current_user]
  if !@user
    redirect "/403"
  else
    haml :'user/settings'
  end
end

put "/settings" do
  @user = session[:current_user]
  if !@user
    redirect "/403"
  end
  if @user.try(:authenticate, params[:password])
    if params[:email] != @user.email
      @user.update(email: params[:email])
    end
    if params[:new_password] == params[:new_password_confirm] && params[:new_password] != ""
      @user.update(password: params[:new_password],
      password_confirmation: params[:new_password_confirm])
    end
    redirect "/settings"
  else
    "[ERROR] invalid password"
  end
end
