# frozen_string_literal: true

require_relative 'car'

class PassengerCar < Car
  def to_s
    "Пассажирский #{super} с свободными местами #{free_capacity}/#{capacity}"
  end
end
