class NumbersDetector
  attr_accessor :pattern

  def initialize(pattern)
    @pattern = pattern.split('').map(&:to_i)
  end

  def self.call(pattern)
    new(pattern).call
  end

  def call
    batches_digits.map do |batch_digits|
      number = batch_digits[0]
      times = batch_digits.size
      digit_numbers[number].call(times)
    end.join
  end

  def digit_numbers
    result ||= {}
    return result[:numbers] if result[:numbers]

    digit_numbers = {
      2 => ('a'..'c'),
      3 => ('d'..'f'),
      4 => ('g'..'i'),
      5 => ('j'..'l'),
      6 => ('m'..'o'),
      8 => ('t'..'v'),
      7 => ('p'..'s'),
      9 => ('w'..'z')
    }.transform_values { |value| ->(times) { find_letter(value, times) } }

    util_numbers = {
      1 => ->(_value) { '' },
      0 => ->(value) { ' ' * value }
    }
    result[:numbers] = digit_numbers.merge(util_numbers)
  end

  def find_letter(letters, times)
    letters_batch = letters.to_a
    letters_batch[(times - 1) % letters_batch.length]
  end

  def batches_digits
    @batches_digits ||= {}
    return @batches_digits if @batches_digits[:result]

    @batches_digits[:result] = []
    temp = []
    pattern.each.with_index do |element, index|
      temp.push(element)
      if element != pattern[index + 1]
        @batches_digits[:result].push(temp)
        temp = []
      end
    end
    @batches_digits[:result]
  end
end

p NumbersDetector.call('443355555566604466690277733099966688')
