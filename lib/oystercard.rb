# it describes Oystercard behaviour
class Oystercard
  attr_reader :balance, :max_balance, :min_balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(max_balance = MAX_BALANCE, min_balance = MIN_BALANCE, travel = false)
    @balance = 0
    @max_balance = max_balance
    @min_balance = min_balance
    @travel = travel
  end

  def top_up(top_up_value)
    raise 'Maximum balance exceeded' if balance + top_up_value > max_balance
    @balance += top_up_value
  end

  def deduct(deducted_value)
    @balance -= deducted_value
  end

  def touch_in
    raise 'Insuficient balance' if balance < min_balance
    @travel = true if @travel == false
  end

  def touch_out
    deduct(1.5)
    @travel = false if @travel == true
  end

  def in_journey?
    @travel
  end
end
