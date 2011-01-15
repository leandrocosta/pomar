require 'spec_helper'

describe MainController do
	render_views

	describe "failure" do
		describe "GET 'index'" do
			it "should not be successful" do
				get :index
				response.should_not be_success
			end
		end
	end

	describe "success" do
		before do
			@user = User.create!(
				:name => "John",
				:email => "john@sub.domain",
				:username => "john",
				:password => "password",
				:password_confirmation => "password"
			)
			session[:user_id] = @user.id
		end

		describe "GET 'index'" do
			it "should be successful" do
				get :index
				response.should be_success
				response.should have_selector('title', :content => 'Pomar!')
				response.should have_selector('a', :href => '/users/' + @user.id.to_s + '/edit', :content => 'Settings')
			end
		end
	end
end
