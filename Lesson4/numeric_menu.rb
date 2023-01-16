# frozen_string_literal: true

require_relative 'user_input'
# Menu with numeric choices.
class NumericMenu
  attr_reader :start_text

  def initialize(data: nil)
    @quit = false
    @current_choice = nil
    @data = data
    @value_to_return = nil
    @start_text = ''
  end

  def menu
    return nil if quit?

    @value_to_return = nil
    until quit?
      puts start_text
      take_user_choice
      process_user_choice
    end
    @value_to_return
  end

  protected

  attr_accessor :current_choice

  def take_user_choice
    self.current_choice = UserInput.take_array_index_choice(menu_discription.keys)
  end

  def process_user_choice
    if current_choice.nil?
      quit!
      return
    end

    process_user_choice!
  end

  def process_user_choice!
    send menu_discription.values[current_choice]
  end

  def quit?
    @quit
  end

  def quit!
    @quit = true
  end

  # { "Описание пункта меню" => :метод_который_будет_вызван ... }. Без выхода.
  def menu_discription
    raise 'Not implemented'
  end
end
