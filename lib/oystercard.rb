class Oystercard
  attr_reader :balance, :max_balance
  MAX_BALANCE = 90

  def initialize(max_balance = MAX_BALANCE, travel=false)
    @balance = 0
    @max_balance = max_balance
    @travel = travel
  end

  def top_up(top_up_value)
    fail 'Maximum balance exceeded' if balance + top_up_value > max_balance
    @balance += top_up_value
  end

  def deduct(deducted_value)
    @balance -= deducted_value
  end

  def touch_in
    @travel = true if @travel == false
  end

  def touch_out
    @travel = false if @travel == true
  end

  def in_journey?
    @travel
  end

end
