class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start = 0
  end

  def [](i)
    if i >= @count
      return nil
    elsif i < 0
      return nil if i < -(@count)
      return self[@count + i]
    end

    @store[(@start + i) % capacity]
  end

  def []=(i, val)
    if i >= @count
      (i - @count).times { push(nil) }
    elsif i < 0
      return nil if i < -(@count)
      return self[@count + i] = val
    end

    if i == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[(@start + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.any? { |el| el == val }
  end

  def push(val)
    resize! if capacity == @count
    @store[(@start + @count) % capacity] = val
    @count += 1
  end

  def unshift(val)
    resize! if capacity == @count
    @start = (@start - 1) % capacity
    @store[@start] = val
    @count += 1
  end

  def pop
    return nil if @count == 0
    last_item = @store[(@start + @count - 1) % capacity]
    @count -= 1
    last_item
  end

  def shift
    return nil if @count == 0
    @count -= 1
    first_item = @store[@start]
    @start = (@start + 1) % capacity
    first_item
  end

  def first
    return nil if @count == 0
    @store[@start]
  end

  def last
    return nil if @count == 0
    @store[(@start + @count - 1) % capacity]
  end

  def each
    @count.times do |i|
       yield(self[i])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.length

    self.each_with_index do |el, i|
      return false unless el == other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    self.each_with_index do |el, i|
      new_store[i] = el
    end

    @store = new_store
    @start = 0
  end
end
