# frozen_string_literal: true

require_relative 'user_input'
# Menu with numeric choices.
class NumericMenu
  attr_reader :start_text

  def initialize(data: nil)
    @quit = false
    @quit_once = false
    @current_choice = nil
    @data = data
    @value_to_return = nil
    @start_text = ''
  end

  def menu(start_text = '')
    return nil if quit?

    @start_text = start_text
    start_actions
    until loop_condition
      loop_actions
    end
    finish_actions
    @value_to_return
  end

  protected

  attr_accessor :current_choice

  def start_actions
    @value_to_return = nil
  end

  def loop_actions
    puts start_text
    puts menu_text
    take_user_choice
    UserInput.clear
    process_user_choice
  end

  def finish_actions
    @quit_once = false
  end

  def loop_condition
    quit? || quit_once?
  end

  def menu_text
    UserInput.array_as_numeric_list(discriptions_to_methods_all.keys)
  end

  def take_user_choice
    self.current_choice = UserInput.take_ranged_choice(0...discriptions_to_methods_all.size)
  end

  def process_user_choice
    process_user_choice! unless current_choice.nil?
  end

  def process_user_choice!
    send discriptions_to_methods_all.values[current_choice]
  end

  def quit?
    @quit
  end

  def quit!
    @quit = true
  end

  def quit_once?
    @quit_once
  end

  def quit_once!
    @quit_once = true
  end

  def quit_description
    { 'Выход' => :quit! } # TODO: не выход, а назад
  end

  def discriptions_to_methods_all
    quit_description.merge(discriptions_to_methods)
  end

  # { "Discription of the choice" => :method_that_will_be_called ... }. Without quit.
  def discriptions_to_methods # TODO: может сделать descriptions_from_index и methods_from_index ?
    raise 'Not implemented'
  end
end
