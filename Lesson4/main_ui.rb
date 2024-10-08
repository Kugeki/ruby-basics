# frozen_string_literal: true

require_relative 'user_input'
require_relative 'numeric_menu'
require_relative 'routes_manager_ui'
require_relative 'trains_manager_ui'
require_relative 'data'

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'cargo_car'

class MainUi < NumericMenu
  attr_accessor :data

  def initialize(data: nil)
    super data: data
  end

  protected

  def menu_discription
    { 'Создать станцию' => :create_station,
      'Создать поезд' => :create_train,
      'Создать маршрут' => :create_route,
      'Управление поездами' => :manage_trains,
      'Управление маршрутами' => :manage_routes,
      'Показать список станций' => :stations_list,
      'Показать список поездов' => :trains_list,
      'Показать список маршрутов' => :routes_list }
  end

  def create_station
    puts 'Введите название станции: '
    data.stations << Station.new(gets.chomp)
  end

  def create_train
    train_types = %w[Пассажирский Грузовой]
    train_type = UserInput.take_array_choice(train_types, 'Выберите тип поезда: ')
    return if train_type.nil?

    puts 'Введите номер поезда: '
    number = gets.chomp
    data.trains << PassengerTrain.new(number) if train_type == train_types[0]
    data.trains << CargoTrain.new(number) if train_type == train_types[1]
  end

  def create_route
    start = UserInput.take_array_choice(data.stations, 'Выберите начальную станцию: ')
    return if start.nil?

    finish = UserInput.take_array_choice(data.stations, 'Выберите конечную станцию: ')
    return if finish.nil?

    data.routes << Route.new(start, finish) unless start.nil? || finish.nil?
  end

  def manage_trains
    train = UserInput.take_array_choice(data.trains, 'Выберите поезд, которым хотите управлять: ')
    return if train.nil?

    trains_manager_ui = TrainsManagerUi.new(train, data: data)
    trains_manager_ui.menu
  end

  def manage_routes
    route = UserInput.take_array_choice(data.routes, 'Выберите маршрут, которым хотите управлять: ')
    return if route.nil?

    routes_manager_ui = RoutesManagerUi.new(route, data: data)
    routes_manager_ui.menu
  end

  def stations_list
    data.print_stations
  end

  def trains_list
    data.print_trains
  end

  def routes_list
    data.print_routes
  end
end
