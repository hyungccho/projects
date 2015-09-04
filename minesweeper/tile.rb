class Tile

  attr_accessor :value

  def initialize(value = 0, hidden = true, flagged = false)
    @value = value
    @hidden = hidden
    @flagged = flagged
  end

  def bomb?
    @value == "X"
  end

  def set_to_bomb
    @value = "X"
  end

  def add_value
    @value += 1 unless self.bomb?
  end

  def show
    @hidden = false
  end

  def hidden?
    @hidden
  end

  def flag
    @flagged = !@flagged
  end

  def flagged?
    @flagged
  end

  def has_value?
    @value.to_i > 0
  end
end
