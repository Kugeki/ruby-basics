puts 'Введите число, месяц, год через пробел:'
day, month, year = gets.chomp.split.map(&:to_i)

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

leap = (year % 400).zero? || ((year % 4).zero? && (year % 100).nonzero?)
days_in_month[1] = 29 if leap

day_from_year_start = days_in_month[0...(month - 1)].sum + day
puts day_from_year_start
