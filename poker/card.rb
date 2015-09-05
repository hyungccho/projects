class Card

  SUITS = [:diamond, :clubs, :hearts, :spades]
  VALUES = {
    ace: "A", two: "2", three: "3", four: "4", five: "5",
    six: "6", seven: "7", eight: "8", nine: "9", ten: "10", jack: "J",
    queen: "Q", king: "K"
  }

  attr_reader :suit, :value

  def initialize(value, suit)
    @suit = suit
    @value = value
    @hidden = true
  end

  def to_s
    "#{VALUES[@value]}#{@suit[0].capitalize}"
  end

  def hidden?
    @hidden
  end

  def show!
    @hidden = !@hidden
  end
end
