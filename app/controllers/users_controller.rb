class UsersController < ApplicationController
	def new
		@title = "Pomar: Sign Up!"
		@user = User.new
	end

	def create
		# http://guides.rubyonrails.org/security.html
		# 6 Mass Assignment - Without any precautions Model.new(params[:model]) allows attackers to set any database column’s value.
		# @user = User.new(params[:user])

		@user = User.new
		@user.name = params[:user][:name]
		@user.email = params[:user][:email]
		@user.username = params[:user][:username]
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]

		respond_to do |format|
			if @user.save
				key = ConfirmationKey.find_by_user_id(@user.id)
				Mailer.notify_signup(params[:user][:email], key.key).deliver

				format.html { redirect_to(@user, :notice => 'User was successfully created!') }
				format.xml  { render :xml => @user, :status => :created, :location => @user }
			else
				@title = "Pomar: Sign Up!"
				format.html { render :action => "new" }
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	def show
		@user = User.find(params[:id])

		respond_to do |format|
			format.html
			format.xml { render :xml => @user }
		end
	end

	def confirm
		if params[:key].blank? then
			flash.now[:notice] = 'Confirmation key required!'
		else
			unless ConfirmationKey.exists?(:key => params[:key]) then
				flash.now[:notice] = 'Error: The confirmation key is invalid!'
			else
				key = ConfirmationKey.find_by_key(params[:key])
				user = key.user
				user.confirmed = true

				if user.save(:validate => false) # active record should not validate fields, because password and password_confirmation don't exist now
					key.destroy
					flash.now[:notice] = 'Your account was confirmed!'
				else
					flash.now[:notice] = 'Error: It was not possible to confirm the user!'
				end
			end
		end
	end
end
