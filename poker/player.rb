require_relative 'hand'

class Player

  attr_reader :name, :hand
  attr_accessor :current_bets, :raise_count, :status

  def initialize(name, money, deck)
    @name = name
    @money = money
    @hand = Hand.new(deck)
    @dealer = false
    @current_bets = 0
    @raise_count = 0
    @status = nil
  end

  def dealer?
    @dealer
  end

  def set_unset_dealer
    @dealer = !@dealer
  end

  def raise(amount)
  end

  def call_check
  end

  def fold
  end

  def reset!
    @current_bets = 0
    @raise_count = 0
    @status = nil
  end

  def pay(amount)
    @money += amount
  end
end
