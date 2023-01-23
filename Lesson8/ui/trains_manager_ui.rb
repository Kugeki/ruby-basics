# frozen_string_literal: true

require_relative '../station'
require_relative '../route'
require_relative '../train'
require_relative '../passenger_train'
require_relative '../cargo_train'
require_relative '../passenger_car'
require_relative '../cargo_car'

class TrainsManagerUi < NumericMenu
  attr_accessor :train, :data

  def initialize(train, data:)
    super data: data
    @train = train
  end

  protected

  def menu_discription
    { 'Назначить маршрут поезду' => :assign_route,
      'Переместить поезд вперёд по маршруту' => :move_forward,
      'Переместить поезд назад по маршруту' => :move_back,
      'Создать и прицепить вагон к поезду' => :attach_car,
      'Отцепить вагон от поезда' => :detach_car,
      'Занять место/объём в вагоне' => :take_capacity,
      'Вывести список вагонов' => :cars_list }
  end

  def start_text
    "Управление поездом #{train}"
  end

  private

  def assign_route
    route = data.routes.take_choice "Выберите маршут, который вы хотите назначить поезду #{train.number}:"
    return if route.nil?

    train.assign_route(route)
    puts "Маршрут #{route} успешно назначен поезду #{train.number}!"
  end

  def move_forward
    train.go_next_station
  rescue RuntimeError => e
    puts e.message
  end

  def move_back
    train.go_previous_station
  rescue RuntimeError => e
    puts e.message
  end

  def attach_car
    if train.car_type == PassengerCar
      puts 'Введите количество мест, которое будет вмещать вагон: '
    else
      puts 'Введите объём, который будет вмещать вагон: '
    end

    train.attach_car(train.car_type.new(gets.to_i))
    puts "Вагон успешно прицеплен поезду #{train.number}!"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def detach_car
    car = train.cars.take_choice 'Выберите вагон'
    return if car.nil?

    train.detach_car(car)
    puts "Вагон успешно отцеплен от поезда #{train.number}!"
  rescue RuntimeError => e
    puts e.message
  end

  def take_capacity
    car = train.cars.take_choice 'Выберите вагон'
    return if car.nil?

    if car.instance_of? PassengerCar
      take_seat(car)
    else
      take_volume(car)
    end
  rescue RuntimeError => e
    puts e.message
  end

  def take_seat(car)
    car.take_seat
    puts "Одно место успешно занято! Осталось #{car.free_seats}."
  end

  def take_volume(car)
    puts "Свободный объём: #{car.free_volume}. Введите количество объёма, который надо занять:"
    volume = gets.to_f
    car.take_volume(volume)
    puts "#{volume} объёма успешно занято! Осталось #{car.free_volume}."
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def cars_list
    i = 1
    train.each_car do |car|
      puts "#{i}) #{car}"
      i += 1
    end
  end
end
