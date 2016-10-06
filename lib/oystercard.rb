# it describes Oystercard behaviour
class Oystercard
  attr_reader :balance, :max_balance, :min_balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1.5
  MIN_CHARGE = 1.5
  PENALTY_FARE = 6

  def initialize(max_balance = MAX_BALANCE, min_balance = MIN_BALANCE)
    @balance = 0
    @max_balance = max_balance
    @min_balance = min_balance
  end

  def top_up(top_up_value)
    raise 'Maximum balance exceeded' if balance + top_up_value > MAX_BALANCE
    @balance += top_up_value
  end

  def deduct(deducted_value)
    @balance -= deducted_value
  end

  def touch_in_balance
    @balance
    raise 'Insuficient balance' if balance < MIN_BALANCE
  end

  def touch_out
    deduct(MIN_CHARGE)
  end
end
