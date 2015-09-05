require_relative 'deck'
require_relative './module/poker_hands'
require_relative './module/hand_comparer'

class Hand
  include PokerHands

  HANDS = [:sf, :fk, :fh, :flush, :straight, :tk, :tp, :pair, :hc]

  attr_reader :deck, :hand, :tally

  def initialize(deck)
    @hand = []
    @deck = deck
    @significant_card = []
  end

  def receive_cards(n)
    n.times do
      @hand << @deck.pop
    end
  end

  def drop_cards!(cards)
    @hand.reject! do |card|
      cards.include?(card.to_s)
    end
  end

  def flush?
    suits = hand.map do |card|
      card.suit
    end

    suits.count(suits.first) == 5
  end

  def straight?
    indices = hand.map do |card|
      Card::VALUES.keys.index(card.value)
    end

    return true if indices.sort! == [0, 10, 11, 12, 13]

    start_index = indices.sort.first
    indices.each_index do |i|
      return false if i + start_index != indices[i]
    end
    true
  end
end

if __FILE__ == $PROGRAM_NAME
  deck = Deck.new
  hand = Hand.new(deck)

  hand.receive_cards(5)
  hand.determine_hand
end
