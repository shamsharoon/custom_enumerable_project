module Enumerable
  # Your code goes here
  
  def my_each_with_index
    # this returns an enumerator if no block is given for an iterable object
    # this is a good practice to follow
    return to_enum(:my_each_with_index) unless block_given?

    for i in 0...length
      yield self[i], i
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    for i in 0...length
      # << means to append to the array
      # we will append the element to the array if the block returns true
      # ex: [1,2,3].my_select { |x| x > 1 } will return [2,3]
      selected << self[i] if yield(self[i])
    end
    selected
  end

  def my_any?
        return to_enum(:my_any?) unless block_given?

    # this will be true if any element is true
    # if all elements are false, it will return false
    for i in 0...length
      return true if yield(self[i])
    end
    false
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?
    
    # this will be true if all elements are true
    # if any element is false, it will return false
    for i in 0...length
      return false unless yield(self[i])
    end
    true
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    for i in 0...length
      return false if yield(self[i])
    end
    true
  end

  def my_count
    return length unless block_given?

    count = 0
    for i in 0...length
      # this will increment the count if the block returns true
      count += 1 if yield(self[i])
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []
    for i in 0...length
      mapped << yield(self[i])
    end
    mapped  # Added the missing return value
  end

  def my_inject(initial = nil, sym = nil)
    if initial.is_a?(Symbol) || initial.is_a?(String)
      sym = initial
      initial = nil
    end

    if sym.nil?
      return to_enum(:my_inject, initial) unless block_given?
    else
      return to_enum(:my_inject, initial, sym) unless block_given?
    end

    accumulator = initial || self[0]
    start_index = initial ? 0 : 1

    for i in start_index...length
      accumulator = yield(accumulator, self[i])
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
  
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in 0...length
      yield self[i]
    end
    self
  end
end
