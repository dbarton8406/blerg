class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    user_id = session[:user_id]
    user_id && User.find(user_id)
  end

  def authenticate_user!
    unless current_user
      flash[:notice] = "You have to be logged in to do that."
      redirect_to login_path
    end
  end
end
