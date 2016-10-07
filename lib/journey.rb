class Journey
  attr_reader :entry_station, :exit_station
  MIN_CHARGE = 1
  PENALTY_FARE = 6

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def fare
    journey_complete? ? MIN_CHARGE : PENALTY_FARE
  end

  private

  def journey_complete?
    @entry_station && @exit_station
  end
end
