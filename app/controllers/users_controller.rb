class UsersController < ApplicationController
  def new
    @title = "Pomar: Sign Up!"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
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

#  def index
#      @users = User.all
#
#    respond_to do |format|
#      format.html
#      format.xml { render :xml => @users }
#    end
#  end
end
