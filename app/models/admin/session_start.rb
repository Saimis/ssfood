module Admin
  class SessionStart
    # TODO: Totally refactor!
    def initialize
      User.update_all(food: nil, sum: nil)
      Restaurant.update_all(votes: 0)
      time_gap = 1200
      food_time_gap = 2400
      callers = select_caller
      payers = select_payer
      garbage_collectors = select_garbage_collector
      order = Order.create(
        date: Time.now + time_gap,
        food_datetime: Time.now + time_gap + food_time_gap,
        caller: callers[1],
        callers: YAML::dump(callers[0]),
        payer: payers[1],
        payers: YAML::dump(payers[0]),
        gc: garbage_collectors[1],
        gcs: YAML::dump(garbage_collectors[0]),
        complete: false)

      User.all.each do |user|
        OrderUser.create(user_id: user.id, order_id: order.id)
      end
    end

    def select_caller
      callers =  Order.last.nil? ? [] : YAML::load(Order.last.callers)
      callers = [callers.last] if callers.size >= user_count
      caller = get_randon_user(callers)
      callers << caller.id
      return callers, caller.id
    end

    def select_payer
      payers =  Order.last.nil? ? [] : YAML::load(Order.last.payers)
      payers = [payers.last] if payers.size >= user_count
      payer = get_randon_user(payers)
      payers << payer.id
      return payers, payer.id
    end

    def select_garbage_collector
      garbage_collectors =  Order.last.nil? ? [] : YAML::load(Order.last.gcs)
      garbage_collectors = [garbage_collectors.last] if garbage_collectors.size >= user_count
      garbage_collector = get_randon_user(garbage_collectors)
      garbage_collectors << garbage_collector.id
      return garbage_collectors, garbage_collector.id
    end

    def get_randon_user(ids)
      @temp_list = [] if @temp_list.nil?
      id_list = ids + @temp_list
      id_list.uniq!
      id_list = [] if id_list.size >= user_count
      condition = id_list.empty? ? '' : "id not in (#{id_list.join(",")})"
      users = User.without_admins.enabled.where(condition)
      user = users.shuffle.first
      @temp_list << user.id
      user
    end

    def user_count
      User.without_admins.enabled.count
    end
  end
end
