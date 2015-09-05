require_relative 'player'
require 'byebug'

class Game

  def initialize(start_money = 50000)
    @start_money = start_money
    @players = []
    @round_players = []
    @dealer = nil
    @pot = 0
    @deck = Deck.new.shuffle
  end

  def setup
    puts "How many players?"
    num_players = gets.chomp.to_i

    num_players.times do
      puts "What is your name?"
      name = gets.chomp

      @players << Player.new(name, @start_money, @deck)
    end

    @round_players = @players
    @dealer = @players.first
  end

  def start_game
    setup
    until game_over?
      play_round
      @players.reject! { |player| player.money == 0 }
    end
  end

  def play_round
    deal_cards
    take_bets
    take_swaps
    take_bets

    winner = determine_winner
    if winner.length > 1
      split_pot(winner.length)
      puts "Split pot!"

      winner.each do |player|
        puts "#{player}.name takes #{@pot / winner.length}!"
      end
    else
      winner[0].pay(@pot)
      puts "#{winner[0].name} takes #{@pot}!"
    end

    reset_round!
    switch_dealer!
    new_deck!
  end

  def new_deck!
    @deck.restore_deck!
  end

  def reset_round!
    @round_players = @players
    @pot = 0

    @players.each do |player|
      player.reset!
    end
  end

  def split_pot(num)
    split = @pot / num
    @round_players[0..(num - 1)].each do |player|
      player.pay(split)
    end
  end

  def determine_winner
    @round_players.sort_by! { |player| Hand::HANDS.index(player.hand.determine_hand[0]) }
    #sort the players by the rank of their highest hand

    sorted_hands = @round_players.map { |player| player.hand.determine_hand }
    #map the players by their full hands

    sorted_hands.each do |hand|
      hand[1].map! { |card| Card::VALUES.keys.index(card) }
    end
    #map the sorted hands significant_cards array by the rank of the significant cards

    tied_hands = sorted_hands.select { |hand| hand[0] == sorted_hands[0][0] }
    if sorted_hands[0][0] == sorted_hands[1][0]
      #if the sorted hands have more than one person with the highest complete hand

      winning_hand = sorted_hands.select { |hand| hand[0] == sorted_hands[0][0] }
      #select the hands that have the same highest complete hand

      i = 0
      while i < winning_hand[0][1].length
        #loop through the winning complete hands
        significant_cards = []
        winning_hand.each do |hand|
          significant_cards << hand[1][i]
        end
        #select the hands at their most important significant_card

        if significant_cards.all? { |sig_card| sig_card == significant_cards[0] }
          #if all the significant_cards at this index are the same, then loop through again
          i += 1
        else
          #if there are differences in their significant cards, loop through
          #the cards and keep track of the highest_significant_card
          highest_significant = nil

          significant_cards.each do |sig_card|
            if sig_card == 0
              highest_significant = 0
            elsif highest_significant.nil? || (sig_card > highest_significant && highest_significant != 0)
              highest_significant = sig_card
            end
          end
          #select and return the hand where the significant card at this
          #particular index is equal to the current highest_significant
          ultimate_hand = winning_hand.select { |hand| hand[1][i] == highest_significant }
          index_of_winner = sorted_hands.each_index.select {|i| sorted_hands[i] == ultimate_hand }
          return [@round_players[index_of_winner]]
        end
        @round_players[0..(tied_hands.length - 1)]
      end
    else
      [@round_players[0]]
    end
  end

  def display_cards(player)
    holder = ""
    player.hand.hand.each do |card|
      holder += "#{card.to_s} | "
    end
    puts holder
  end

  def take_swaps
    @round_players.rotate!(1)
    @round_players.each do |player|
      display_cards(player)
      puts "#{player.name}'s turn to swap!"
      puts "How many cards would you like to swap? (0 to 3)"
      num = gets.chomp.to_i

      cards = []
      num.times do
        puts "What kind do you want to swap?"
        cards << gets.chomp
      end

      player.hand.drop_cards!(cards)
      player.hand.receive_cards(num)
    end
  end

  def deal_cards
    @players.each do |player|
      player.hand.receive_cards(5)
    end
  end

  def switch_dealer!
    @players.first.set_unset_dealer
    @players.rotate!(1)
    @players.first.set_unset_dealer
  end

  def bet_prompt(player)
    puts "#{player.name}'s turn!"
    puts "Raise (r), Call/Check(c), Fold(f)"
    move = gets.chomp

    if move == "r"
      raise InvalidMoveError if player.raise_count == 1
      puts "Enter the amount you'd like to bet:"
      amount = gets.chomp.to_i
      largest_bet = @round_players.max_by { |player| player.current_bets }.current_bets

    if player.current_bets + amount < largest_bet
        raise InvalidMoveError
      else
        @pot += amount
        player.current_bets += amount
        player.raise_count += 1
      end
      return :raise
    elsif move == "c"
      largest_bet = @round_players.max_by { |player| player.current_bets }.current_bets

      if player.current_bets == largest_bet
        return :check
      else
        amount = largest_bet - player.current_bets
        @pot += amount
        player.current_bets += amount
        return :call
      end
    elsif move == "f"
      return :fold
    end
  end

  def take_bets
    largest_bet = @round_players.max_by { |player| player.current_bets }.current_bets

    until @round_players.all? { |player| player.current_bets == largest_bet && largest_bet > 0 } || @round_players.count == 1 || @round_players.all? { |player| player.status == :check }
      puts "\nPOT SIZE: #{@pot}"
      @round_players.rotate!(1)
      display_cards(@round_players.first)
      move = bet_prompt(@round_players.first)
      @round_players.first.status = move
      @round_players.delete(@round_players.first) if move == :fold
      largest_bet = @round_players.max_by { |player| player.current_bets }.current_bets
    end

    @players.each do |player|
      player.reset!
    end
  end

  def game_over?
    @players.count == 1
  end
end

class NotEnoughPlayersError < StandardError
end

class InvalidMoveError < StandardError
end
