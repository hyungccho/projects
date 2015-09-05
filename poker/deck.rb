require_relative 'card'

class Deck

  attr_reader :cards

  def initialize
    @cards = restore_deck!
  end

  def restore_deck!
    deck = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value, _|
        deck << Card.new(value, suit)
      end
    end
    deck
  end

  def shuffle
    @cards.shuffle!
  end
end
