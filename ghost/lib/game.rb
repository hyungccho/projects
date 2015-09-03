require 'set'
require_relative 'player'

class Game

  attr_reader :dictionary, :players, :fragment, :current_dictionary

  def initialize(dictionary)
    @dictionary = dictionary
    @current_dictionary = dictionary
    @players = []
    @fragment = ""
    @current_player = nil
  end

  def take_turn
    puts "\n#{@current_player.name}'s turn!"
    puts "Choose a letter!"
    letter = gets.chomp

    valid_words = current_dictionary.select { |word| word.start_with?(fragment + letter) }
    if valid_words.empty?
      raise InvalidLetterError
    elsif letter.length != 1
      raise InvalidLetterError
    else
      @fragment = fragment + letter
    end
    system 'clear'
  end

  def play_round
    until complete_word?
      begin
        take_turn
      rescue InvalidLetterError
        puts "Invalid Letter, try again!"
        retry
      end
      show_current_word
      switch_players!
      shorten_dictionary
    end
    handle_round
  end

  def play_game
    until game_over?
      play_round
    end
    declare_winner
  end

  private

    def declare_winner
      puts "#{players.first.name} is the winner!"
    end

    def game_setup
      begin
        puts "How many players?"
        number = gets.chomp.to_i
        raise NotEnoughPlayersError if number < 2
      rescue NotEnoughPlayersError
        puts "You must play with at least 2 players!"
        retry
      end

      number.times do |i|
        puts "Enter your name!"
        name = gets.chomp
        players << Player.new(name)
      end

      @current_player = players.first
      system 'clear'
    end

    def show_current_word
      puts "Current word: #{@fragment}"
    end

    def switch_players!
      players.rotate!(1)
      @current_player = players[0]
    end

    def game_over?
      players.count == 1
    end

    def handle_round
      players[-1].add_letter
      show_standings
      reset_round

      if players[-1].lost?
        puts "#{players[-1].name} has lost the game!"
        players.pop
      end

      puts "New round!"
      sleep 2
    end

    def reset_round
      @current_dictionary = dictionary
      @fragment = ""
    end

    def show_standings
      puts "#{players[-1].name} spelled a word!"

      players.each do |player|
        puts "#{player.name}: #{player.letters}"
      end
    end

    def complete_word?
      dictionary.include?(fragment)
    end

    def shorten_dictionary
      @current_dictionary = dictionary.select { |word| word.start_with?(fragment) }
    end

end

class InvalidLetterError < StandardError
end

class NotEnoughPlayersError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  dictionary = Set.new
  File.open("../dictionary.txt").each do |line|
    dictionary << line.chomp
  end

  game = Game.new(dictionary)
  game.play_game
end
