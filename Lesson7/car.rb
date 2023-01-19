# frozen_string_literal: true

require_relative 'manufacturer'

class Car
  include Manufacturer
  attr_reader :free_capacity, :capacity

  def initialize(capacity = 0)
    @capacity = capacity
    validate!

    @free_capacity = capacity
  end

  def take_capacity
    raise 'Всё место уже занято.' if free_capacity.zero?

    @free_capacity -= 1
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
end
