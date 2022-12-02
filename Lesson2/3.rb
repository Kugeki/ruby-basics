first = 0
second = 1

fibonacci = [first, second]
100.times do
  first, second = second, first + second
  fibonacci << second
end

puts fibonacci
