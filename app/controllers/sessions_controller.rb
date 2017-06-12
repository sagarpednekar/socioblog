class SessionsController < ApplicationController
	def new
		
	end

	def create
		user =User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have been Succesfully Loged In"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "Problem with User Information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have succesfully loged out"
		redirect_to root_path
	end
end