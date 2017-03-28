get "/admin" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  else
    haml :'admin/adminPanel'
  end
end
