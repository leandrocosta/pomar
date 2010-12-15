class SessionsController < ApplicationController
	def new
		@title = "Pomar: Sign In!"
	end

	def create
		user = User.authenticate(params[:username], params[:password]);

		#if (params[:username].blank? || params[:password].blank?)
		if (user.blank?)
			flash.now[:alert] = "Invalid username/password combination"
			render :action => 'new'
		else
			#session[:user_id] = 1
			session[:user_id] = user.id
			redirect_to main_path, :notice => "You are logged in!"
		end
	end

	def destroy
		reset_session
		redirect_to '/', :notice => "Your are logged out"
	end
end
