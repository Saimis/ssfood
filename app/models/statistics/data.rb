module Statistics
  class Data
    extend Memoist

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def data
      {
        user_votes: user_votes,
        restaurants_win: restaurants_win_data,
        users_votes_data: users_votes_data,
        users_food_data: users_food_data,
        users_callers_data: users_callers_data
      }
    end

    private

    def user_votes
      return [] unless user

      OrderUser
        .includes(:restaurant)
        .where(user_id: user.id)
        .where.not(restaurant_id: nil)
        .group_by(&:restaurant)
        .map { |restaurant, orders| [restaurant.name, orders.count] }
    end

    def restaurants_win_data
      restaurants = Restaurant.all
      restaurants_data = []
      restaurants.map { |r| restaurants_data.push([ r.name, Order.where(restaurant_id: r.id).count ]) }
      restaurants_data
    end

    def users_callers_data
      users_data = []
      users.map { |u| users_data.push([ u.short_name, Order.where(caller_id: u.id).count ]) }
      users_data
    end

    def users_votes_data
      users_data = []
      users.map { |u| users_data.push([ u.short_name, counter(u.id) ]) }
      users_data
    end

    def users_food_data
      users_data = []
      users.map { |u| users_data.push([u.short_name, counter(u.id)]) }
      users_data
    end

    memoize def counter(uid)
      OrderUser.where(user_id: uid).where('food IS NOT NULL').count
    end

    memoize def users
      User.without_admins
    end
  end
end
