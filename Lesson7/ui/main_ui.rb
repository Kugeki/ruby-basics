# frozen_string_literal: true

require_relative 'user_input'
require_relative 'numeric_menu'
require_relative 'routes_manager_ui'
require_relative 'trains_manager_ui'

require_relative '../app_data'
require_relative '../station'
require_relative '../route'
require_relative '../train'
require_relative '../passenger_train'
require_relative '../cargo_train'

require_relative '../car'
require_relative '../passenger_car'
require_relative '../cargo_car'

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
      'Показать список маршрутов' => :routes_list,
      'Показать список поездов на станции' => :trains_on_station_list }
  end

  private

  # текстовый интерфейс для создания станций
  def create_station
    puts 'Введите название станции: '
    name = gets.chomp
    data.stations << Station.new(name)
  rescue RuntimeError => e
    return if name == '0'

    puts "#{e.message} Повторите или введите 0 для выхода."
    retry
  end

  # текстовый интерфейс для создания поездов
  def create_train
    train_type = train_type_input
    return if train_type.nil?

    number = train_number_input
    return if number.nil?

    data.trains << train_type.new(number)
  end

  def train_type_input
    train_types = [PassengerTrain, CargoTrain]
    index = UserInput.take_array_index_choice(%w[Пассажирский Грузовой], 'Выберите тип поезда: ')
    train_types[index]
  end

  def train_number_input
    puts 'Введите номер поезда: '
    number = gets.chomp
    number.tap { Train.validate_number!(number) }
  rescue RuntimeError => e
    return nil if number == '0'

    puts "#{e.message} Повторите или введите 0 для выхода."
    retry
  end

  # текстовый интерфейс для создания маршрутов
  def create_route
    start = UserInput.take_array_choice(data.stations, 'Выберите начальную станцию: ')
    return if start.nil?

    finish = UserInput.take_array_choice(data.stations, 'Выберите конечную станцию: ')
    return if finish.nil?

    data.routes << Route.new(start, finish) unless start.nil? || finish.nil?
  end

  # текстовый интерфейс для управления поездами
  def manage_trains
    train = UserInput.take_array_choice(data.trains, 'Выберите поезд, которым хотите управлять: ')
    return if train.nil?

    trains_manager_ui = TrainsManagerUi.new(train, data: data)
    trains_manager_ui.menu
  end

  # текстовый интерфейс для управления маршрутами
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

  def trains_on_station_list
    station = UserInput.take_array_choice(data.stations, 'Выберите станцию:')
    return if station.nil?

    i = 1
    station.each_train do |train|
      puts "#{i}) #{train}"
      i += 1
    end
  end
end
