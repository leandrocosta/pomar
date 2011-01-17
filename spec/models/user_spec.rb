require 'spec_helper'

describe User do
	before(:all) do
		@username = 'john'
		@password = 'password'

		@valid_attributes = {
			:name => 'John',
			:username => @username,
			:password => @password,
			:password_confirmation => @password,
			:email => 'mail@sub.domain'
		}
	end

	describe "validations" do
		describe "presence and format" do
			before(:all) do
				@user = User.new
			end

			it "should validate name" do
				@user.should have(1).error_on(:name)
				@user.errors[:name].should include "can't be blank"
			end

			it "should validate email" do
				@user.should have(2).error_on(:email)
				@user.errors[:email].should include "can't be blank"
				@user.errors[:email].should include "is invalid"
			end

			it "should validate username" do
				@user.should have(1).error_on(:username)
				@user.errors[:username].should include "can't be blank"
			end

			it "should validate password" do
				@user.should have(2).error_on(:password)
				@user.errors[:password].should include "can't be blank"
				@user.errors[:password].should include "is too short (minimum is 6 characters)"
			end
		end

		it "should validate password's confirmation" do
			user = User.new @valid_attributes
			user.password_confirmation = ''

			user.should have(1).error_on(:password)
			user.errors[:password].should include "doesn't match confirmation"
		end

		it "should validate uniqueness of username and email" do
			User.create!(@valid_attributes)
			user = User.new(@valid_attributes)

			user.should have(1).error_on(:username)
			user.errors[:username].should include "has already been taken"

			user.should have(1).error_on(:email)
			user.errors[:email].should include "has already been taken"
		end

		it "should validate data correctly" do
			User.new(@valid_attributes).should be_valid
		end
	end

	describe "database persistence" do
		before(:each) do
			@user = User.new(@valid_attributes)
		end

		it "should hash password with a salt before create" do
			@user.save
			@user.hashed_password.should eql User.encrypt(@user.password, @user.sha1_salt)
		end

		it "should hash password with a salt before update" do
			@user.save
			@user.password = 'new password'
			@user.password_confirmation = 'new password'
			@user.save
			@user.hashed_password.should eql User.encrypt(@user.password, @user.sha1_salt)
		end

		it "should create a confirmation key after create" do
			lambda do
				@user.save
			end.should change(ConfirmationKey, :count).by(1)

			ConfirmationKey.find_by_key(User.encrypt(@user.email, @user.sha1_salt)).should be_true
		end
	end

	describe "authentication" do
		before(:each) do
			User.create!(@valid_attributes)
		end

		it "should return nil if invalid values are used" do
			User.authenticate(nil, nil).should be_nil
		end

		it "should return the user if valid values are used" do
			User.authenticate(@username, @password).username.should eql @username
		end
	end
end
