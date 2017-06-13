class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    helper_method :current_user, :loged_in? 
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def loged_in?
  	!!current_user
  end

  def require_user
  	if !loged_in?
  		flash[:danger] = "You must Loged in to perfome this action"
  		redirect_to root_path
  	end
  	
  end


end
