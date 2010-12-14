require 'spec_helper'

describe User do
	before do
		@username = 'john'
		@password = 'password'

		@user = User.new
		@user.name = 'John'
		@user.username = @username
		@user.password = @password
		@user.password_confirmation = @password
		@user.email = 'mail@sub.domain'
	end

	describe "validations" do
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
	end

	describe "database writing" do
		it "should hash the password with a salt before create" do
			@user.save
			@user.hashed_password.should eql User.encrypt(@user.password, @user.sha1_salt)
		end

		it "should hash the password with a salt before update" do
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
	  before do
		  @user.save
	  end

	  it "should return nil if invalid values are used" do
		  User.authenticate(nil, nil).should be_nil
	  end

	  it "should return the user if valid values are used" do
		  User.authenticate(@username, @password).username.should eql @user.username
	  end
  end
end
