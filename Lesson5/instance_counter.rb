# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
      @instances
    end
  end

  protected

  def register_instance
    self.class.instances += 1
  end
end
