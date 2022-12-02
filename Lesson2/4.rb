vowels = 'aeiou'
char_by_num = ('a'..'z').zip(1..26).to_h.select { |char, _| vowels.include?(char) }
puts char_by_num
