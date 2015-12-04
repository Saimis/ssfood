module MainHelper
  def current_round
    @current_round ||= Archyves.last
  end

  def current_round_ended?
    Time.zone.now > current_round.food_datetime
  end

  def caller?
    current_round.caller == @current_user.try(:id)
  end
end
