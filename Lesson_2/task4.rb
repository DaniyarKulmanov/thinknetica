vowel = 'aeoui'
vowel_arr = {}

('a'..'z').each.with_index(1) do |word, index|
  vowel_arr[word.to_sym] = index if vowel.include? word
end

puts vowel_arr
