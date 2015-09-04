class Tile

  attr_accessor :value
  attr_reader :given

  def initialize(value, given = false)
    @value = value.to_i
    @given = given
  end

  def to_s
    @value == 0 ? "X" : @value.to_s
  end

  def equals?(num)
    @value == num
  end

  def given?
    @given
  end
end
