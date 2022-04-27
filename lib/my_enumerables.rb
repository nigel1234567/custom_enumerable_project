module Enumerable
  # Your code goes here
  def my_each
    return to_enum(:my_each) unless block_given?

    for el in self do
      yield el
    end
    self
  end

  def my_each_with_index(*args)
    return to_enum(:my_each_with_index, *args) unless block_given?
    i = 0
    for el in self do
      yield el, i
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    results = []
    my_each { |elem| results.push(elem) if yield elem}
    results
  end

  # def my_all?
  #   return to_enum(:my_all) unless block_given?
    
  #   results = []
  #   my_each { |elem| results.push(true) if yield elem}
  #   i = 0
  #   for el in self do
  #     i += 1
  #   end

  #   if results.count(true) == i
  #     true
  #   else
  #     false
  #   end
  # end

  # Pattern matching solution
  def my_all?(pattern = nil)
    # Test if block is given. If true: yield, if false: nil
    expr = block_given? ? ->(elem) { yield elem } : ->(elem) { pattern === elem }
    # Test each element if true, return false if any does not match
    my_each { |elem| return false unless expr.call(elem) }
    # If doesn't return false, run next line to return true
    true
  end

  def my_any?(pattern = nil)
    expr = block_given? ? ->(elem) { yield elem } : ->(elem) { pattern === elem }
    # Looks through whole array until an element returns true
    my_each { |elem| return true if expr.call(elem)}
    # If no element returns true, return false
    false
  end

  # Opposite of any
  def my_none?(pattern = nil)
    expr = block_given? ? ->(elem) { yield elem } : ->(elem) { pattern === elem }
    my_each { |elem| return false if expr.call(elem) }
    true
  end

  # def my_count
  #   return length unless block_given?
  #   results = []
  #   my_each { |elem| results.push(true) if yield elem}
  #   i = results.count(true)
  #   i
  # end

  # Pattern matching
  def my_count(item = nil)
    return length if item.nil? && !block_given?

    count = 0
    expr = block_given? ? ->(elem) { count += 1 if yield elem } : ->(elem) { count += 1 if item === elem }
    my_each { |elem| expr.call(elem)}
    count
  end

  def my_map(block = nil)
    return to_enum(:my_map) if !block_given? && block.nil?
    expr = block_given? ? ->(elem) {yield elem} : ->(elem) {pattern === elem}
    results = []
    my_each { |elem| results.push(expr.call(elem))}
    results
  end

  def my_inject accumulator = nil # Same as reduce
    self.size.times do |index|
      if accumulator == nil && index == 0
        accumulator = self[index]
        next
      end
      accumulator = yield accumulator, self[index]
    end
    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
end
