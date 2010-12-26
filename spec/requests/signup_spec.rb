require 'spec_helper'

describe "SignUp" do
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Pomar: Sign Up!")
  end
end
