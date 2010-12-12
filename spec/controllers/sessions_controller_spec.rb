require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      #visit 'new'
      #page.status_code.should == 200
      get 'new'
      response.should be_success
      response.should have_selector("title", :content => "Pomar: Sign In!")

      response.should have_selector("label", :content => "Username", :for => "username")
      response.should have_selector("input", :id => "username", :name => "username", :type => "text", :content => nil)

      response.should have_selector("label", :content => "Password", :for => "password")
      response.should have_selector("input", :id => "password", :name => "password", :type => "text", :content => nil)

      response.should have_selector("input", :name => "commit", :type => "submit", :value => "Login")
    end
  end
end
