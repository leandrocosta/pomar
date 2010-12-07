require 'spec_helper'

describe User do
  before do
    @user = User.new
    @user.name = 'John'
    @user.username = 'john'
    @user.password = 'password'
    @user.password_confirmation = 'password'
    @user.email = 'mail@sub.domain'
  end

  it "should validate the presence of name" do
    @user.name = nil
    @user.should_not be_valid
  end

  it "should validate the presence of email" do
    @user.email = nil
    @user.should_not be_valid
  end

  it "should validate the format of email" do
    @user.email = 'invalid@email'
    @user.should_not be_valid
  end

  it "should validate the presence of username" do
    @user.username = nil
    @user.should_not be_valid
  end

  it "should validate the presence of password" do
    @user.password = nil
    @user.should_not be_valid
  end

  it "should validate the password's confirmation" do
    @user.password_confirmation = ''
    @user.should_not be_valid
  end

  it "should validate the uniqueness of username" do
    User.create!(
    :name => 'John2',
    :username => 'john',
    :password => 'password2',
    :password_confirmation => 'password2',
    :email => 'mail2@sub.domain');
    @user.should_not be_valid
  end

  it "should validate data correctly" do
    @user.should be_valid
  end

  it "should hash the password with a salt before create" do
    @user.before_create
    @user.hashed_password.should eql User.encrypt(@user.password, @user.password_salt)
  end

  it "should hash the password with a salt before update" do
    @user.before_create
    @user.password = 'new password'
    @user.password_confirmation = 'new password'
    @user.before_update
    @user.hashed_password.should eql User.encrypt(@user.password, @user.password_salt)
  end

  it "should create a confirmation key before create" do
    lambda do
      @user.before_create
    end.should change(ConfirmationKey, :count).by(1)

    ConfirmationKey.find_by_key(User.encrypt(@user.email, @user.password_salt)).should be_true
  end
end
