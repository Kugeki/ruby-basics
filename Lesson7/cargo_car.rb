# frozen_string_literal: true

require_relative 'car'

class CargoCar < Car
  alias volume capacity
  alias free_volume free_capacity
  alias taken_volume taken_capacity

  def take_volume(volume)
    raise 'Объём не может быть отрицательным.' if volume.negative?

    take_capacity(volume)
  end

  def to_s
    "Грузовой #{super} со свободным объёмом #{free_capacity}/#{capacity}"
  end
end
