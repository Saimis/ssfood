class User < ActiveRecord::Base
  has_secure_password

  before_create :create_remember

  def admin?
    name == 'admin'
  end

  private

  def create_remember
    self.remember = SecureRandom.urlsafe_base64
  end
end
