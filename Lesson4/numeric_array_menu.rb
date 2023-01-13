# frozen_string_literal: true

require_relative 'numeric_menu'

class NumericArrayMenu < NumericMenu
  def initialize(array, data: nil)
    super data: data
    @array = array
  end

  protected

  def process_user_choice!
    if current_choice.zero?
      quit!
      return
    end

    @value_to_return = @array[current_choice - 1]
    quit_once!
  end

  def discriptions_to_methods
    @array.each_with_object({}) { |element, result| result[element] = nil }
  end
end
