require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Pomar: Sign Up!")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :username => "", :password => "", :password_confirmation => "" }
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Pomar: Sign Up!")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :name => "John", :email => "john@sub.domain", :username => "john", :password => "johnjohn", :password_confirmation => "johnjohn" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end
  end

  describe "GET 'confirm'" do
    it "should be successful" do
      #get 'confirm'
      #response.should be_success
      visit 'confirm'
      page.status_code.should == 200
    end

    describe "failure" do
      before(:each) do
        ConfirmationKey.destroy_all
      end

      it "should look for parameter key in querystring" do
        visit 'confirm'
        page.should have_content 'Confirmation key required!'
      end

      it "should look for parameter key in database" do
        visit 'confirm?key=1'
        page.should have_content 'Error: The confirmation key is invalid!'
      end
    end

    describe "success" do
      before(:each) do
        #User.destroy_all
		#ConfirmationKey.destroy_all
        @user = User.create!( :name => "John", :email => "john@sub.domain", :username => "john", :password => "johnjohn", :password_confirmation => "johnjohn" )
        key = ConfirmationKey.create!( :key => "1234567890123456789012345678901234567890" )
		key.user = @user
		key.save
      end

      it "should confirm a valid key" do
        lambda do
          visit 'confirm?key=1234567890123456789012345678901234567890'
        end.should change(ConfirmationKey, :count).by(-1)

        page.should have_content 'Your account was confirmed!'
        ConfirmationKey.find_by_key("1234567890123456789012345678901234567890").should be_nil
        #User.find(1).enabled.should be_true
		#User.find(1).should_not be_nil
		#User.find(1).enabled.should be_true
        #user = User.find(1);
        #e = user.enabled
        #e.should be_true
        #@user.enabled.should be_true
		@user.reload
		@user.name.should eql 'John'
        @user.confirmed.should be_true
      end
    end
  end
end
