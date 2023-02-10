# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(name, validation_type, arg = nil)
      @validations ||= []
      @validations.push(["@#{name}".to_sym, validation_type, arg].compact)
    end

    def validations
      @validations || []
    end
  end

  def validate!
    self.class.validations.each do |validation|
      case validation
      in [name, :presence]
        validate_presence!(name)
      in [name, :format, expression]
        validate_format!(name, expression)
      in [name, :type, type]
        validate_type!(name, type)
      end
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  def validate_presence!(name)
    var = instance_variable_get(name)
    raise "Переменная #{name} является nil!" if var.nil?
    raise "Переменная #{name} является пустой строкой!" if var == ''
  end

  def validate_format!(name, expression)
    var = instance_variable_get(name)
    raise "Переменная #{name} не соответствует регулярному выражению #{expression}!" if var !~ expression
  end

  def validate_type!(name, type)
    var = instance_variable_get(name)
    raise "Переменная #{name} не соответствует типу #{type}!" unless var.instance_of?(type)
  end
end

# class RailwayStation; end
# class FooStation; end

# class A
#   include Validation

#   validate :name, :presence
#   validate :number, :format, /^[A-Z]{0,3}$/
#   validate :station, :type, RailwayStation

#   def initialize(name, number, station)
#     @name = name
#     @number = number
#     @station = station
#     validate!
#   end
# end

# A.new(nil, 'AAA', RailwayStation.new)
# A.new('Opa', '2345r32', RailwayStation.new)
# A.new('Opa', 'AAA', FooStation.new)
# A.new('Opa', 'AAA', RailwayStation.new)
