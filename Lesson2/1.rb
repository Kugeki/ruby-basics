require 'date'
days_in_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months = Date::MONTHNAMES

days_by_month_name = months.zip(days_in_month)[1..].to_h

puts '30 дней в месяцах:'
days_by_month_name.each { |month, days| puts month if days == 30 }
