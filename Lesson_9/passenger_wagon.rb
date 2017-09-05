require_relative 'wagon'

# passenger wagon class
class PassengerWagon < Wagon
  attr_reader :seats_all

  def initialize(seats)
    @seats_all = seats
    super 'Passenger'
    @seats_occupied = 0
  end

  def occupy_seat
    return if @seats_all <= 0
    @seats_all -= 1
    @seats_occupied += 1
  end

  def occupied_seats
    @seats_occupied
  end

  def free_seats
    @seats_all
  end

  private

  def validate! # TODO: create validate module and include in classes
    super
    raise 'Seats must be a number' if @seats_all.class != Integer
    true
  end
end
