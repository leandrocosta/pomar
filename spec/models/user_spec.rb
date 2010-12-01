require 'spec_helper'

describe User do
  before do
    @user = User.new
    @user.name = 'John'
    @user.username = 'john'
    @user.hashed_password = 'HASHED_PASSWORD'
    @user.email = 'mail@domain'
  end

  it "should have a name" do
    @user.name.should be == 'John'
  end

  it "should have a username" do
    @user.username.should be == 'john'
  end

  it "should have a hashed_password" do
    @user.hashed_password.should be == 'HASHED_PASSWORD'
  end

  it "should have an e-mail" do
    @user.email.should be == 'mail@domain'
  end
end
