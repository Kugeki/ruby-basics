# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  attr_accessor :start, :finish, :midways

  include Validation
  validate :start, :presence
  validate :finish, :presence

  include InstanceCounter

  def initialize(start, finish)
    @start = start
    @finish = finish
    @midways = []
    validate!
    register_instance
  end

  def add(station)
    midways << station
  end

  def delete(station)
    midways.delete(station)
  end

  def size
    midways.size + 2
  end

  def all
    [start, midways, finish].flatten
  end

  def [](index)
    return nil if index.negative?

    all[index]
  end

  def to_s
    return "#{start.name}-#{finish.name}" if midways.size.zero?

    "#{start.name}-#{midways.map(&:name).join '-'}-#{finish.name}"
  end
end
