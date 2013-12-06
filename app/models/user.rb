class User < ActiveRecord::Base
  has_secure_password
  #attr_accessible :email, :password, :password_confirmation

  before_create :create_remember

  private

  def create_remember
    self.remember = SecureRandom.urlsafe_base64
  end
end
