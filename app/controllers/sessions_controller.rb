class SessionsController < ApplicationController
  def new
    @title = "Pomar: Sign In!"
  end

  def create
    if (params[:username].blank? || params[:password].blank?)
      flash.now[:alert] = "Invalid username/password combination"
      render :action => 'new'
    else
      redirect_to main_path, :notice => "You are logged in!"
    end
  end

  def destroy
  end
end
