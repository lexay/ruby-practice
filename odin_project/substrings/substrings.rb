def substrings(string, dictionary)
  words = string.scan /\w+\b/
  dictionary.inject(Hash.new(0)) do |hash, substring|
    words.each do |word|
      hash[substring] += 1 if word.downcase.include? substring
    end
    hash
  end
end
