# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :number, :cars

  @@trains = {}

  def initialize(number)
    @number = number
    @@trains[number] = self
    @speed = 0
    @current_station_number = 0
    @cars = []
    @route = nil
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def speed_up(value)
    @speed += value
  end

  def speed_down(value)
    @speed -= value
  end

  def stop
    self.speed = 0
  end

  def valid_car?(_car)
    true
  end

  def attach_car(car)
    if speed.nonzero?
      puts 'Не получилось. Сбавьте скорость до 0.'
    elsif !valid_car?(car)
      puts 'Не получилось. Не подходящий тип вагона.'
    else
      @cars.push(car)
      puts "Вагон успешно прицеплен поезду #{number}!"
    end
  end

  def detach_car
    if speed.nonzero?
      puts 'Не получилось. Сбавьте скорость до 0.'
    elsif !cars.size.positive?
      puts 'Не получилось. Вагонов нет.'
    else
      @cars.pop
      puts "Вагон успешно отцеплен от поезда #{number}!"
    end
  end

  def assign_route(route)
    @route = route
    @current_station_number = 0
    @route[0].add(self)
  end

  def go_next_station
    go_station_with_direction(1)
  end

  def go_previous_station
    go_station_with_direction(-1)
  end

  def next_station
    @route[current_station_number + 1]
  end

  def current_station
    @route[current_station_number]
  end

  def previous_station
    @route[current_station_number - 1]
  end

  def to_s
    return "поезд с номером #{number}" if @route.nil?

    route_name = @route.to_s
    station_name = current_station.name
    "поезд с номером #{number} и маршрутом #{route_name} на станции #{station_name}"
  end

  private

  # private, т.к. не должно использаться пользователем
  attr_reader :current_station_number

  # private, т.к. пользователю нельзя перепрыгивать через станции
  def current_station_number=(value)
    if value < @route.size && value >= 0
      @current_station_number = value
    elsif value.negative?
      puts "Ошибка. Поезд #{number} уже на первой станции."
    else
      puts "Ошибка. Поезд #{number} уже на последней станции."
    end
  end

  # private, т.к. не должно использаться пользователем
  def go_station_with_direction(direction)
    return if direction.zero? || @route.nil?

    current_station.delete(self)
    self.current_station_number += 1 if direction.positive?
    self.current_station_number -= 1 if direction.negative?
    current_station.add(self)
  end
end
