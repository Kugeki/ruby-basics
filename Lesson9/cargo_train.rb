# frozen_string_literal: true

class CargoTrain < Train
  def valid_car?(car)
    car.instance_of? CargoCar
  end

  def car_type
    CargoCar
  end

  def to_s
    "Грузовой #{super}"
  end
end
