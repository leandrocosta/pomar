class SessionsController < ApplicationController
  def new
    @title = "Pomar: Sign In!"
  end

  def create
    if (params[:username].blank? || params[:password].blank?)
      flash.now[:alert] = "Invalid username/password combination"
      render :action => 'new'
    end
  end

  def destroy
  end
end
