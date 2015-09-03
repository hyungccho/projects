class Player

  attr_reader :correct_flips, :name

  def initialize(name)
    @name = name
    @correct_flips = 0
  end

  def add_correct_flip
    @correct_flips += 1
  end
end
