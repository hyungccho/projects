class Player

  attr_reader :name, :losses
  attr_accessor :letters

  def initialize(name)
    @name = name
    @letters = ""
    @losses = 0
  end

  def lost?
    letters == "GHOST"
  end

  def add_letter
    ghost = "GHOST"
    @letters += ghost[losses]
    @losses += 1
  end

end
