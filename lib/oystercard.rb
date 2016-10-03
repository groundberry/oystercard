class Oystercard
  attr_reader :balance, :max_balance
  MAX_BALANCE = 90

  def initialize(max_balance = MAX_BALANCE)
    @balance = 0
    @max_balance = max_balance
  end

  def top_up(top_up_value)
    fail 'Maximum balance exceded' if balance + top_up_value > max_balance
    @balance += top_up_value
  end
end
