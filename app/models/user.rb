class User < ActiveRecord::Base
	has_one :confirmation_key, :dependent => :destroy

	before_create :make_hashed_password
	before_update :make_hashed_password
	after_create :create_confirmation_key

	attr_accessor :password, :password_confirmation # needed because they don't exist in database
	attr_protected :hashed_password, :sha1_salt, :confirmed

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,		:presence => true, :length => { :maximum => 60 }
	validates :email,		:presence => true, :length => { :maximum => 60 }, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
	validates :username,	:presence => true, :length => { :maximum => 60 }, :uniqueness => { :case_sensitive => false }
	validates :password,	:presence => true, :confirmation => true, :length => { :within => 6..20 }

	def make_hashed_password
		unless @password.blank?
			make_salt if self.sha1_salt.blank?
			self.hashed_password = User.encrypt(@password, self.sha1_salt)
		end
	end

	def create_confirmation_key
		key = ConfirmationKey.create!(:key => User.encrypt(self.email, self.sha1_salt))
		key.user = self
		key.save
	end

	def make_salt
		self.sha1_salt = Digest::SHA1.hexdigest(self.username + Time.now.to_s)
	end

	def authenticated?(password)
		self.hashed_password == User.encrypt(password, self.sha1_salt)
	end

	def self.encrypt(password, salt)
		Digest::SHA1.hexdigest(password + salt)
	end

	def self.authenticate(username, password)
		user = find_by_username(username)
		return user if user && user.authenticated?(password)
	end
end
