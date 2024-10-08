# frozen_string_literal: true

require_relative 'numeric_menu'

require_relative '../route'
require_relative '../station'

class RoutesManagerUi < NumericMenu
  attr_accessor :route, :data

  def initialize(route, data:)
    super data: data
    @route = route
  end

  protected

  def menu_discription
    { 'Добавить промежуточную станцию' => :add_midway_station,
      'Удалить промежуточную станцию' => :delete_midway_station,
      'Изменить начальную станцию' => :change_start_station,
      'Изменить конечную станцию' => :change_finish_station }
  end

  def start_text
    "Управление маршрутом #{route}"
  end

  private

  def stations_outside_route
    data.stations.reject { |station| route.all.include? station }
  end

  def add_midway_station
    station = stations_outside_route.take_choice 'Выберите станцию для добавления:'
    return if station.nil?

    route.add(station)
    puts "Успешно добавлена станция #{station}!"
  end

  def delete_midway_station
    station = route.midways.take_choice 'Выберите станцию для удаления:'
    return if station.nil?

    route.delete(station)
    puts "Успешно удалена станция #{station}!"
  end

  def change_start_station
    station = stations_outside_route.take_choice 'Выберите станцию для назначения начальной:'
    return if station.nil?

    route.start = station
    puts "Успешно изменена начальная станция на #{station}!"
  end

  def change_finish_station
    station = stations_outside_route.take_choice 'Выберите станцию для назначения конечной:'
    return if station.nil?

    route.finish = station
    puts "Успешно изменена конечная станция на #{station}!"
  end
end
