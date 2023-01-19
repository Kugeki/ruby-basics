# frozen_string_literal: true

require_relative 'car'

class CargoCar < Car
  def to_s
    "Грузовой #{super} со свободным объёмом #{free_capacity}/#{capacity}"
  end
end
