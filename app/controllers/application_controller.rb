class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :require_logged_in
  helper_method :current_user, :logged_in?, :admin?


  def logged_in?
    session[:user_id]
  end

  def require_logged_in
    redirect_to root_path unless logged_in?
  end

    def admin_access_only
      if !admin?
        flash[:notice] = "You must be an admin to view that page"
        redirect_to current_user
      end
    end

  def current_user
    @user = User.find_by_id(session[:user_id])
  end

  def admin?
    current_user.admin if logged_in?
  end

end
