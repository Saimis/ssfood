class User < ActiveRecord::Base
  has_secure_password

  before_create :create_remember

  scope :without_admins, -> { where.not(name: 'admin') }
  scope :enabled, -> { where(disabled: false) }

  def admin?
    name == 'admin'
  end

  private

  def create_remember
    self.remember = SecureRandom.urlsafe_base64
  end
end
