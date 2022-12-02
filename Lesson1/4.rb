puts 'Введите a:'
a = gets.to_i
puts 'Введите b:'
b = gets.to_i
puts 'Введите c:'
c = gets.to_i

discriminant = b * b - 4 * a * c
x1 = 0
x2 = 0
unless discriminant.negative?
  x1 = (Math.sqrt(discriminant) - b) / (2 * a)
  x2 = (-Math.sqrt(discriminant) - b) / (2 * a)
end

if discriminant.positive?
  puts "Дискриминант: #{discriminant}. x1: #{x1}. x2: #{x2}."
elsif discriminant.negative?
  puts "Дискриминант: #{discriminant}. Корней нет."
else
  puts "Дискриминант: #{discriminant}. x: #{x1}."
end
