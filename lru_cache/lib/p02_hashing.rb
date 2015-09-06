class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 0
    self.each_with_index do |num, i|
      hashed += ((i + 1) * num.hash)
    end
    hashed
  end
end

class String
  def hash
    self.split("").map(&:ord).hash
  end
end

class Hash
  def hash
    hash = 0
    self.each do |key,value|
      hash += ((key.hash * 2) + (value.hash * 3))
    end
    hash
  end
end
