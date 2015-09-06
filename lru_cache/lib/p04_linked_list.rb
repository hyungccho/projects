class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    current_link = @head
    until current_link.next.nil?
      current_link = current_link.next
    end
    current_link
  end

  def empty?
    @head.next.nil?
  end

  def get(key)
    current_link = @head

    until current_link.key == key
      return nil if current_link.next.nil?
      current_link = current_link.next
    end

    current_link.val
  end

  def include?(key)
    current_link = @head

    until current_link.nil?
      return true if current_link.key == key
      current_link = current_link.next
    end

    false
  end

  def insert(key, val)
    last.next = Link.new(key, val)
  end

  def remove(key)
    current_link = @head

    until current_link.next.key == key
      current_link = current_link.next
    end

    current_link.next = current_link.next.next
  end

  def each(&prc)
    current_link = first

    until current_link.nil?
      prc.call(current_link)
      current_link = current_link.next
    end

    self
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
