# frozen_string_literal: true

module UserInput
  class << self
    def take_ranged_choice(range)
      loop do
        input = gets.chomp
        return nil if input.to_i.zero? && /\d+/.match?(input)
        return input.to_i if range.include? input.to_i

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

class Array
  def take_choice(text = '')
    UserInput.take_array_choice(self, text)
  end

  def take_index_choice(text = '')
    UserInput.take_array_index_choice(self, text)
  end

  def as_numeric_list
    UserInput.array_as_numeric_list(self)
  end
end
