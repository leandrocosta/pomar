class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :hashed_password, :password_salt, :confirmed
  attr_protected :hashed_password#, :password_salt

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      :presence => true, :length => { :maximum => 60 }
  validates :email,     :presence => true, :length => { :maximum => 60 }, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :username,  :presence => true, :length => { :maximum => 60 }, :uniqueness => { :case_sensitive => false }
  validates :password,  :presence => true, :confirmation => true, :length => { :within => 6..20 }

  def before_create
    make_salt if @password_salt.blank?
    ConfirmationKey.create!(:key => User.encrypt(self.email, @password_salt))
    @hashed_password = User.encrypt(@password, @password_salt)
  end

  def before_update
    @hashed_password = User.encrypt(@password, @password_salt) unless @password.blank?
  end

  def make_salt
    @password_salt = self.username + Time.now.to_s
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest(password + salt)
  end
end
