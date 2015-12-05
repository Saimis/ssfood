class Order < ActiveRecord::Base
  belongs_to :restaurant

  belongs_to :caller, class_name: 'User'
  belongs_to :payer, class_name: 'User'
  belongs_to :garbage_collector, class_name: 'User'

  def current?
    date > Time.zone.now
  end
end
