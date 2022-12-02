products = {}
loop do
  puts 'Введите название товара:'
  name = gets.chomp
  break if name == 'стоп'

  puts 'Введите через пробел цену за единицу и кол-во купленного товара'
  cost, count = gets.chomp.split.map(&:to_f)

  products[name] = { cost: cost, count: count }
end

puts products
products.each { |name, info| puts "#{name} в сумме стоит #{info[:cost] * info[:count]}" }

costs_sum = products.sum { |_, info| info[:cost] * info[:count] }
puts "Все товары стоят #{costs_sum}"
