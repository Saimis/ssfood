module Admin
  class AmountsManager
    extend Memoist

    def call
      {
        order: last_order,
        order_users: order_users,
        total: total
      }
    end

    private

    def total
      order_users.sum(:sum)
    end

    memoize def order_users
      return OrderUser.none unless last_order

      OrderUser
        .includes(:user)
        .where(order: last_order, user_id: users.ids)
    end

    # === HELPERS

    memoize def users
      User.without_admins.enabled
    end

    memoize def last_order
      Order.includes(:restaurant).last
    end
  end
end
