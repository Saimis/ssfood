class User < ActiveRecord::Base
  #attr_accessible :email, :password, :password_confirmation

  #before_save { |user| user.name = name.downcase }
  before_create :create_remember

  private
  
  def create_remember
    self.remember = SecureRandom.urlsafe_base64
  end
end
