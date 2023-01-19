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
    text = "Выберите маршут, который вы хотите назначить поезду #{train.number}:"
    route = UserInput.take_array_choice(data.routes, text)
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
    car = UserInput.take_array_choice(train.cars, 'Выберите вагон')
    return if car.nil?

    train.detach_car(car)
    puts "Вагон успешно отцеплен от поезда #{train.number}!"
  rescue RuntimeError => e
    puts e.message
  end

  def take_capacity
    car = UserInput.take_array_choice(train.cars, 'Выберите вагон')
    return if car.nil?

    car.take_capacity
    puts '1 единица места успешна занята!'
  rescue RuntimeError => e
    puts e.message
  end

  def cars_list
    i = 1
    train.each_car do |car|
      puts "#{i}) #{car}"
      i += 1
    end
  end
end
