class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation # needed because they don't exist in database
  attr_protected :hashed_password, :sha1_salt, :confirmed

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      :presence => true, :length => { :maximum => 60 }
  validates :email,     :presence => true, :length => { :maximum => 60 }, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :username,  :presence => true, :length => { :maximum => 60 }, :uniqueness => { :case_sensitive => false }
  validates :password,  :presence => true, :confirmation => true, :length => { :within => 6..20 }

  def before_create
    make_salt if self.sha1_salt.blank?
    self.hashed_password = User.encrypt(@password, self.sha1_salt) unless @password.blank?
  end

  def after_create
    key = ConfirmationKey.create!(:key => User.encrypt(self.email, self.sha1_salt))
    key.user = self
    key.save
  end

  def before_update
    self.hashed_password = User.encrypt(@password, self.sha1_salt) unless @password.blank?
  end

  def make_salt
    self.sha1_salt = Digest::SHA1.hexdigest(self.username + Time.now.to_s)
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest(password + salt)
  end
end
