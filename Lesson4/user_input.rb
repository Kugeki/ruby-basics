# frozen_string_literal: true

class UserInput
  class << self
    def take_ranged_choice(range)
      loop do
        input = gets.to_i
        return nil if input.zero?
        return input if range.include? input

        puts 'Неправильный ввод. Повторите или напишите 0 для выхода.'
      end
    end

    def take_array_index_choice(array, text = '')
      puts text
      puts '0) Выход'
      puts array_as_numeric_list(array)
      index = take_ranged_choice(1...(array.size + 1))
      clear
      return nil if index.nil?

      index - 1
    end

    def take_array_choice(array, text = '')
      index = take_array_index_choice(array, text)
      return nil if index.nil?

      array[index]
    end

    def array_as_numeric_list(array, params = {})
      result = String.new
      array.each_with_index do |element, i|
        result << "#{i + 1}) #{element}\n"
      end
      params.fetch(:begin, '') + result + params.fetch(:end, '')
    end

    def clear
      system('clear') || system('cls')
    end
  end
end
