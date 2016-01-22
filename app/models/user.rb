class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true

  before_create :create_remember

  scope :without_admins, -> { where.not(name: 'admin') }
  scope :enabled, -> { where(disabled: false) }

  def admin?
    name == 'admin'
  end

  def short_name
    short_last_name = "#{last_name[1]}." if last_name.present?
    [name.presence, short_last_name].compact.join(' ').titleize
  end

  private

  def create_remember
    self.remember = SecureRandom.urlsafe_base64
  end
end
