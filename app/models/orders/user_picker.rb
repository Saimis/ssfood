module Orders
  class UserPicker
    extend Memoist

    def initialize
      @picked_user_ids = []
    end

    def call
      {
        caller_id: pick_user(:caller),
        payer_id: pick_user(:payer),
        garbage_collector_id: pick_user(:garbage_collector)
      }
    end

    private

    def pick_user(type)
      picked_user_id = available_user_ids(type).sample
      @picked_user_ids << picked_user_id
      picked_user_id
    end

    def available_user_ids(type)
      available_ids = user_ids - order_user_ids(type) - @picked_user_ids
      available_ids.presence || (user_ids - @picked_user_ids)
    end

    def order_user_ids(type)
      column_name = "#{type}_id".to_sym
      orders.map(&column_name)
    end

    memoize def user_ids
      User.without_admins.enabled.pluck(:id)
    end

    memoize def orders
      Order.last(user_ids.length)
    end
  end
end
