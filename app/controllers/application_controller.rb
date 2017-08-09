class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def login(user)
    session[:user_id] = user.id
  end

  def logout(user)
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this page."
      redirect_to login_path
      end
  end
end
