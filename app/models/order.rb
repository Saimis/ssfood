class Order < ActiveRecord::Base
  def current?
    date > Time.zone.now
  end
end
