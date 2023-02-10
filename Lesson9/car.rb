# frozen_string_literal: true

require_relative 'manufacturer'

class Car
  attr_reader :free_capacity, :capacity

  include Manufacturer

  def initialize(capacity = 0)
    @capacity = capacity
    validate!

    @free_capacity = capacity
  end

  def taken_capacity
    capacity - free_capacity
  end

  def validate!
    raise 'Количество места не может быть отрицательным' if @capacity.negative?
  end

  def to_s
    'вагон'
  end

  protected

  def take_capacity(amount)
    raise 'Не хватает свободного места.' if (free_capacity - amount).negative?

    @free_capacity -= amount
  end
end
