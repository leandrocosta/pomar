require 'spec_helper'

describe "Users" do
	describe "GET 'new'" do
		it "should be successful" do
			get new_user_path
			response.should be_success
			response.should have_selector("title", :content => "Pomar: Sign Up!")
		end
	end
end
