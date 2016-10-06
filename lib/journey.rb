class Journey
  attr_reader :entry_station, :exit_station, :journey, :journey_history

  def initialize(travel = false)
    @travel = travel
    @journey = {}
    @journey_history = []
  end

  def journey_start(station)
    @entry_station = station
    @journey[:entry_station] = station
    @travel = true if @travel == false
  end

  def journey_finish(station)
    @entry_station = nil
    @exit_station = station
    @journey[:exit_station] = station
    @travel = false if @travel == true
  end

  def fare
    touch_in || touch_out ? deducted_value = MIN_CHARGE : deducted_value = PENALTY_FARE
  end

  def journey_complete?
    !entry_station
  end

  def history
    journey_history << journey
  end
end
