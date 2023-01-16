# frozen_string_literal: true

require_relative 'ui/user_input'

class Data
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def print_stations
    puts UserInput.array_as_numeric_list(stations, begin: "Список станций\n")
  end

  def print_trains
    puts UserInput.array_as_numeric_list(trains, begin: "Список поездов\n")
  end

  def print_routes
    puts UserInput.array_as_numeric_list(routes, begin: "Список маршрутов\n")
  end
end
