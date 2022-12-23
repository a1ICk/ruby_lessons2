# frozen_string_literal: true

pattern = '443355555566604466690277733099966688'
array = pattern.split('').map(&:to_i)
result = []
temp = []
array.each.with_index do |element, index|
  temp.push(element)
  if element != array[index + 1]
    result.push(temp)
    temp = []
  end
end
p result.map { |array| { array[0] => array.length } }

hash = {
  1 => ->(_value) { '' },
  2 => ->(value) { ('a'..'c').to_a[(value - 1) % 3] },
  3 => ->(value) { ('d'..'f').to_a[(value - 1) % 3] },
  4 => ->(value) { ('g'..'i').to_a[(value - 1) % 3] },
  5 => ->(value) { ('j'..'l').to_a[(value - 1) % 3] },
  6 => ->(value) { ('m'..'o').to_a[(value - 1) % 3] },
  7 => ->(value) { ('p'..'s').to_a[(value - 1) % 4] },
  8 => ->(value) { ('t'..'v').to_a[(value - 1) % 3] },
  9 => ->(value) { ('w'..'z').to_a[(value - 1) % 4] },
  0 => ->(_value) { ' ' }
}

digit_three_numbers = {
  2 => ('a'..'c'),
  3 => ('d'..'f'),
  4 => ('g'..'i'),
  5 => ('j'..'l'),
  6 => ('m'..'o'),
  8 => ('t'..'v'),
  7 => ('p'..'s'),
  9 => ('w'..'z')
}.transform_values { |value| ->(times) { value.to_a[(times - 1) % value.to_a.length] } }

util_numbers = {
  1 => ->(_value) { '' },
  0 => ->(value) { ' ' * value }
}
numbers = digit_three_numbers.merge(util_numbers)
p numbers
