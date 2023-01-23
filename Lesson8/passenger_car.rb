# frozen_string_literal: true

require_relative 'car'

class PassengerCar < Car
  alias seats capacity
  alias free_seats free_capacity
  alias taken_seats taken_capacity

  def take_seat
    take_capacity(1)
  end

  def to_s
    "Пассажирский #{super} с свободными местами #{free_capacity}/#{capacity}"
  end
end
