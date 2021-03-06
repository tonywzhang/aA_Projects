class User < ApplicationRecord
  
  has_many :cats,
  foreign_key: :user_id,
  class_name: :Cat
  
  attr_reader :password
  validates :session_token, :username, presence: true
  validates :password_digest, presence:{message: "Password can't be blank"}
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token
  
  has_many :rental_requests,
    foreign_key: :user_id,
    class_name: :CatRentalRequest
  
  def self.generate_session_token 
    SecureRandom::urlsafe_base64(16)
  end 
  
  def self.find_by_credentials(username, password)  
    @user = User.find_by(username: username)
    return nil unless @user
    @user.is_password?(password) ? @user : nil
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end 
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end 
  
  private
  def ensure_session_token 
    
    self.session_token ||= self.class.generate_session_token
  end 
end
