# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}_history") do
        instance_variable_get("#{var_name}_history") || []
      end

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set("#{var_name}_history", (send "#{name}_history").push(value))
      end
    end
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise "Значение #{value} не соответствует классу #{klass} переменной #{name}" unless value.instance_of? klass

      instance_variable_set(var_name, value)
    end
  end
end

# class RailwayStation; end
# class FooStation; end

# class A
#   extend Accessors
#   attr_accessor_with_history :number
#   strong_attr_accessor :station, RailwayStation

#   def initialize(number, station)
#     @number = number
#     @station = station
#   end
# end

# a = A.new('123', RailwayStation.new)
# a.number = '2345'
# a.number = '99999'
# a.number_history

# a.station = FooStation.new

# a.station = RailwayStation.new
