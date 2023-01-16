# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'cargo_car'

class TrainsManagerUi < NumericMenu
  attr_accessor :train, :data

  def initialize(train, data:)
    super data: data
    @train = train
  end

  protected

  def menu_discription
    { 'Назначить маршрут поезду' => :assign_route,
      'Прицепить вагон к поезду' => :attach_car,
      'Отцепить вагон от поезда' => :detach_car,
      'Переместить поезд вперёд по маршруту' => :move_forward,
      'Переместить поезд назад по маршруту' => :move_back }
  end

  def start_text
    "Управление поездом #{train}"
  end

  def assign_route
    text = "Выберите маршут, который вы хотите назначить поезду #{train.number}:"
    route = UserInput.take_array_choice(data.routes, text)
    return if route.nil?

    train.assign_route(route)
    puts "Маршрут #{route} успешно назначен поезду #{train.number}!"
  end

  def attach_car
    train.attach_car(PassengerCar.new) if train.instance_of? PassengerTrain
    train.attach_car(CargoCar.new) if train.instance_of? CargoTrain
  end

  def detach_car
    train.detach_car
  end

  def move_forward
    train.go_next_station
  end

  def move_back
    train.go_previous_station
  end
end
