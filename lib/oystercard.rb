require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :max_balance, :min_balance, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1.5
  MIN_CHARGE = 1
  PENALTY_FARE = 6

  def initialize(balance = 0)
    @balance = balance
    @max_balance = max_balance
    @min_balance = min_balance
    @journey_history = []
  end

  def top_up(top_up_value)
    raise 'Maximum balance exceeded' if balance + top_up_value > MAX_BALANCE
    @balance += top_up_value
  end

  def touch_in(station)
    raise 'Insuficient balance' if balance < MIN_BALANCE
    complete_journey if @journey && @journey.exit_station.nil?
    @journey = Journey.new
    @journey.start(station)
  end

  def touch_out(station)
    @journey = Journey.new if @journey.nil?
    unless @journey_history.include?(@journey)
      @journey.finish(station)
      complete_journey
    end
  end

  private

  def deduct(deducted_value)
    @balance -= deducted_value
  end

  def complete_journey(station = nil)
    @journey_history << @journey
    deduct(@journey.fare)
  end
end
