# frozen_string_literal: true

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

    @trains.select { |train| train.instance_of?(type) }
  end

  def to_s
    return "#{name} без поездов" if @trains.size.zero?

    "#{name} с поездами: #{@trains.map(&:number).join ', '}."
  end
end
