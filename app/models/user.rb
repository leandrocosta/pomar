class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :hashed_password, :password_salt
  attr_protected :hashed_password, :password_salt

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      :presence => true, :length => { :maximum => 60 }
  validates :email,     :presence => true, :length => { :maximum => 60 }, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :username,  :presence => true, :length => { :maximum => 60 }, :uniqueness => { :case_sensitive => false }
  validates :password,  :presence => true, :confirmation => true, :length => { :within => 6..20 }

  def before_create
    @password_salt = Digest::SHA1.hexdigest(Time.now.to_s) if @password_salt.blank?
    @hashed_password = User.encrypt(@password, @password_salt)
  end

  def before_update
    @hashed_password = User.encrypt(@password, @password_salt)
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest(password+salt)
  end
end
