module Admin
  class AmountsManager
    extend Memoist

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      {
        order: order,
        order_users: order_users,
        total: total
      }
    end

    private

    def total
      order_users.sum(:sum)
    end

    memoize def order_users
      return OrderUser.none unless order

      OrderUser
        .includes(:user)
        .where(order: order, user_id: users.ids)
    end

    # === HELPERS

    memoize def users
      User.without_admins.enabled
    end

    memoize def order
      if params[:id].present?
        Order.includes(:restaurant).find(params[:id])
      else
        last_order
      end
    end

    memoize def last_order
      Order.includes(:restaurant).last
    end
  end
end
