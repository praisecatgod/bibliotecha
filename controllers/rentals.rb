get "/admin/rentals" do
  @user = session[:current_user]
  if !@user || !@user.is_admin
    redirect "/403"
  end
  @active_rentals = Rental.where(["created_at > ?", 1.days.ago] ).where(is_active: true).order('created_at DESC')
  @expired_rentals = Rental.where(["created_at < ?", 1.days.ago] ).where(is_active: true).order('created_at DESC')
  @old_rentals = Rental.where(is_active: false).order('updated_at DESC')

  haml :'admin/adminRentals'
end