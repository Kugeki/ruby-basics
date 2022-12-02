puts 'Введите своё имя: '
name = gets.chomp

puts 'Введите свой рост: '
height = gets.to_i

ideal_weight = (height - 110) * 1.15

if ideal_weight.negative?
  puts 'Ваш вес уже оптимальный'
else
  puts "#{name}, ваш идеальный вес: #{ideal_weight} кг."
end
