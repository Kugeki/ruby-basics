class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add(train)
    @trains << train
  end

  def delete(train)
    @trains.delete(train)
  end

  def trains(type = nil)
    return @trains if type.nil?
    
    @trains.select { |train| train.type == type }
  end
end

class Route
  def initialize(start, finish)
    @start = start
    @finish = finish
    @midways = []
  end

  def add(station)
    @midways << station
  end

  def delete(station)
    @midways.delete(station)
  end

  def size
    @midways.size + 2
  end

  def all
    [@start, @midways, @finish].flatten
  end

  def [](index)
    all[index]
  end

  def to_s
    "#{@start.name}-#{@midways.map(&:name).join '-'}-#{@finish.name}"
  end
end

class Train
  attr_accessor :speed
  attr_reader :number, :type, :cars_count

  def initialize(number, type, cars_count)
    @number = number
    @type = type
    @cars_count = cars_count
    @speed = 0
    @current_station_number = 0
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

  def attach_car
    if speed.zero?
      @cars_count += 1
    else
      puts 'Не получилось. Сбавьте скорость до 0.'
    end
  end

  def detach_car
    if speed.zero? && cars_count.positive?
      @cars_count -= 1
    elsif speed.nonzero?
      puts 'Не получилось. Сбавьте скорость до 0.'
    else
      puts 'Не получилось. Вагонов нет.'
    end
  end

  def assign_route(route)
    @route = route
    @current_station_number = 0
    @route[0].add(self)
  end

  def current_station_number=(value)
    if value < @route.size && value >= 0
      @current_station_number = value
    elsif value.negative?
      puts "Ошибка. Поезд #{number} уже на первой станции."
    else
      puts "Ошибка. Поезд #{number} уже на последней станции."
    end
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
    return nil if (current_station_number - 1).negative?

    @route[current_station_number - 1]
  end

  private

  attr_reader :current_station_number

  def go_station_with_direction(direction)
    return if direction.zero?

    current_station.delete(self)
    self.current_station_number += 1 if direction.positive?
    self.current_station_number -= 1 if direction.negative?
    current_station.add(self)
  end
end

# train = Train.new(1, :passenger, 4)
# train.attach_car
# puts train.cars_count

# train.detach_car
# puts train.cars_count

# train.speed_up 20
# train.speed_down 10
# puts train.speed

# train.attach_car
# train.detach_car

# train.stop
# puts train.speed

# route = Route.new(Station.new('Station1'), Station.new('Station4'))
# route.add(Station.new('Station2'))
# route.add(Station.new('Station3'))
# puts route.to_s

# train.assign_route(route)

# train.go_next_station

# train.current_station
# train.previous_station
# train.next_station

# train.go_previous_station
# train.go_previous_station
# train.go_previous_station

# train.go_next_station
# train.go_next_station
# train.go_next_station
# train.go_next_station
# train.go_next_station

# train2 = Train.new(2, :cargo, 6)
# train.current_station.add(train2)
# train.current_station.trains
# train.current_station.trains(:passenger)
# train.current_station.delete(train2)
# train.current_station.trains
