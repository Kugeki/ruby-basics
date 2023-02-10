# frozen_string_literal: true

class Station
  attr_reader :name

  include InstanceCounter

  @@stations = []
  @@stations_hash = {}

  def initialize(name)
    @name = name
    validate!
    @trains = []

    @@stations << self
    @@stations_hash[name] = self
    register_instance
  end

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations_hash[name]
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

  def each_train(&block)
    trains.each(&block)
  end

  def to_s
    return name if @trains.size.zero?

    "#{name} с поездами: #{@trains.map(&:number).join ', '}."
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise 'Уже есть станция с таким названием.' if self.class.find(name)
  end
end
