# frozen_string_literal: true

class PassengerTrain < Train
  def valid_car?(car)
    car.instance_of? PassengerCar
  end

  def to_s
    "Пассажирский #{super}"
  end
end
