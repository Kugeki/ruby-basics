# frozen_string_literal: true

class UserInput
  class << self
    def take_ranged_choice(range)
      return nil if range.size.zero?

      loop do
        input = gets.to_i
        return input if range.include? input

        puts 'Неправильный ввод. Повторите или напишите 0 для выхода.'
      end
    end

    def take_array_choice(array)
      index = take_ranged_choice(0...array.size)
      return nil if index.nil?

      array[index]
    end

    def array_as_numeric_list(array, params = {})
      result = String.new
      array.each_with_index do |element, i|
        result << "#{i}) #{element}\n"
      end
      params.fetch(:begin, '') + result + params.fetch(:end, '')
    end

    def clear
      system('clear') || system('cls')
    end
  end
end
