class Card

  attr_reader :animal

  def initialize(animal)
    @animal = animal
    @hidden = true
  end

  def to_s
    hidden? ? "*" : @animal[0].capitalize
  end

  def hidden?
    @hidden
  end

  def flip!
    @hidden = !@hidden
  end

  def matches?(card)
    @animal == card.animal
  end

end
