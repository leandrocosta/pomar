class ApplicationController < ActionController::Base
  protect_from_forgery

#  def authorize_access
#	  if !session[:user_id]
#		  flash[:notice] = 'You are not logged in!'
#		  redirect_to '/'
#		  return false
#	  end
#  end

  protected
  def current_user
	  return unless session[:user_id]
	  @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def authenticate
	  logged_in? ? true : access_denied
  end

  def logged_in?
	  current_user.is_a? User
  end

  helper_method :logged_in?

  def access_denied
	  redirect_to signin_path, :alert => "You are not logged in!" and return false
  end
end
