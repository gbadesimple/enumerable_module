module Enumerable
  def my_each
    for item in self
      yield(item)
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    new_array = []
    self.my_each do |item|
      new_array.push(item) if yield(item)
    end
    new_array
  end

  def my_all?
    test = true
    self.my_each do |item|
      test = false if !yield(item)
      break
    end
    return test
  end

  def my_any?
    test = false
    self.my_each do |item|
      test = true if yield(item)
      break
    end
    return test
  end

  def my_none?
    test = true
    self.my_each do |item|
      test = false if yield(item)
      break
    end
    return test
  end

  def my_count
    total = 0
    if block_given?
      self.my_each {|item| total += 1 if yield(item)}
    else
      total = self.count
    end
    return total
  end

  def my_map(&my_proc)
    new_array = []
    self.my_each do |value|
      if my_proc.nil?
        new_array.push(my_proc.call(value))
      else
        new_array.push(yield(value))
      end
    end
    return new_array
  end

  def my_inject(memo=self[0])
    self.my_each_with_index do |value, index|
      memo = yield(memo, value) if index > 0
    end
    return memo
  end
end

def multiply_els(array)
  array.my_inject{|total, n| total*n}
end
