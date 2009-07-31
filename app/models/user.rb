require "digest/sha1"

class User
  include DataMapper::Resource
  attr_accessor :password, :password_confirmation
  property :id,     Serial, :serial => true
  property :login,  String, :nullable => false
  property :admin,  Boolean
  property :email,  String, :nullable => false, :unique => true, :format => :email_address,
    :messages => {
      :presence => "We need your email address.",
      :is_unique => "We already have that email.",
      :format => "Doesn't look like an email address to me..."
    }
  property :crypted_password, String
  property :salt,             String
  
  has n, :comments
  has n, :pages
  has n, :meta, :class_name => "UserMeta", :child_key => [:user_id]
  
  validates_present       :password, :if => proc{|m| m.password_required?}
  validates_is_confirmed  :password, :if => proc{|m| m.password_required?}
  
  before :save, :encrypt_password
  
  def authenticated?(password)
    crypted_password == encrypt(password)
  end
  
  def encrypt(password)
    self.class.encrypt(password, salt)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.login()}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  class << self
    # Encrypts some data with the salt.
    def encrypt(password, salt)
      Digest::SHA1.hexdigest("--#{salt}--#{password}--")
    end
  end
end
