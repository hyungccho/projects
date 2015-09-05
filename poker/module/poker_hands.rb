require_relative 'hand_comparer.rb'

module PokerHands

  def determine_hand
    if straight_flush?
      @completed_hand = [:sf, [high_card(@hand)]]
    elsif four_of_a_kind?
      @completed_hand = [:fk, @significant_card]
    elsif full_house?
      @completed_hand = [:fh, @significant_card]
    elsif flush?
      @completed_hand = [:flush, [high_card(@hand)]]
    elsif straight?
      @completed_hand = [:straight, [high_card(@hand)]]
    elsif three_of_a_kind?
      @completed_hand = [:tk, @significant_card]
    elsif two_pair?
      @completed_hand = [:tp, @significant_card]
    elsif pair?
      @completed_hand = [:pair, @significant_card]
    else
      @completed_hand = [:hc, [high_card(@hand)]]
    end
    @completed_hand
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    values = @hand.map do |card|
      card.value
    end

    2.times do
      if values.count(values.first) == 4
        @significant_card << values.first
        return true
      end

      values.rotate!(1)
    end

    false
  end

  def full_house?
    values = @hand.map do |card|
      card.value
    end

    if values.uniq.length == 2
      @significant_card << values.select { |value| values.count(value) == 3 }.flatten.first
      return true
    end

    false
  end

  def three_of_a_kind?
    values = @hand.map do |card|
      card.value
    end

    values.each do |value|
      if values.count(value) == 3
        @significant_card << value
        return true
      end
    end
    false
  end

  def two_pair?
    values = @hand.map do |card|
      card.value
    end

    if values.uniq.length == 3
      highest_pair = high_card(values.select { |value| values.count(value) == 2 })
      @significant_card << highest_pair
      values.reject! { |value| value == highest_pair }
      @significant_card << values.select { |value| values.count(value) == 2 }.flatten.first
      @significant_card << values.select { |value| values.count(value) == 1 }.flatten.first
      return true
    end
    false
  end

  def pair?
    values = @hand.map do |card|
      card.value
    end

    if values.uniq.length == 4
      @significant_card << values.select { |value| values.count(value) == 2 }.flatten.first
      values.reject! { |value| @significant_card.include?(value) }
      @significant_card << high_card(values)
      return true
    end
    false
  end

  def high_card(hand)
    values = hand.map do |card|
      Card::VALUES.keys.index(card)
    end


    return :ace if values.include?(0)

    Card::VALUES.keys[values.max]
  end
end
