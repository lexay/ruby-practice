def caesar_cipher(str, num = 0)
  lower = ('a'..'z').to_a
  upper = ('A'..'Z').to_a
  index = ->(arr, e) { (arr.index(e) + num) % 26 }

  chars = str.chars
  chars.map do |char|
    if lower.include? char
      new_index = index.call(lower, char)
      lower[new_index]
    elsif upper.include? char
      new_index = index.call(upper, char)
      upper[new_index]
    else
      char
    end
  end.join
end
