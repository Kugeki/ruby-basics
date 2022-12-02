puts 'Введите 3 стороны через пробел:'
sides = gets.chomp.split.map(&:to_i).sort

pifagor = (sides[2]**2 == (sides[0]**2 + sides[1]**2))
unique_sides = sides.uniq.length

if pifagor
  puts 'Треугольник прямоугольный'
elsif unique_sides == 1
  puts 'Треугольник равносторонний'
elsif unique_sides == 2
  puts 'Треугольник равнобедренный'
else
  puts 'Треугольник произвольный'
end
