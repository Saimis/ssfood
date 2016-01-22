class User < ActiveRecord::Base
  has_secure_password

  validates :username, :first_name, :last_name, :email, presence: true

  before_create :create_remember

  scope :without_admins, -> { where.not(first_name: 'admin') }
  scope :enabled, -> { where(disabled: false) }

  def admin?
    first_name == 'admin'
  end

  def name
    "#{first_name} #{last_name}"
  end

  def short_name
    short_last_name = "#{last_name[1]}." if last_name.present?
    [first_name.presence, short_last_name].compact.join(' ').titleize
  end

  private

  def create_remember
    self.remember = SecureRandom.urlsafe_base64
  end
end
