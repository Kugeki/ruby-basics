# frozen_string_literal: true

module Manufacturer
  attr_writer :manufacturer_name

  def manufacturer_name
    @manufacturer_name ||= ''
    @manufacturer_name
  end
end
