require_relative 'board'
require_relative 'player'

class Game

  attr_reader :board, :players

  def initialize
    @players = []
    @board = nil
    @last_turn = []
    @current_player = nil
  end

  def play_turn
    until @last_turn.count == 2
      puts "#{@current_player.name}'s turn!" unless players.count == 1 || @last_turn.count == 1
      puts "What card would you like to flip? (row, col)"
      pos = gets.chomp.split(", ").map(&:to_i)

      if board.valid_move?(pos)
        board[pos].flip!
        @last_turn << pos
      else
        raise InvalidMoveError
      end
      board.display
    end

    sleep 2
    system 'clear'
    handle_turn
    board.display
  end

  def play_game
    game_setup
    until game_over?
      begin
        play_turn
      rescue InvalidMoveError
        puts "Invalid move!"
        retry
      end
      switch_players!
    end
    final_message
  end

  private

    def final_message
      if players.count == 1
        puts "Congratulations, you have won the game!"
      else
        players.each do |player|
          puts "#{player.name} had #{player.correct_flips} correct flips"
        end

        puts "\n\n"
        largest_correct_flips = players.map { |player| player.correct_flips }.max
        winners = players.select { |player| player.correct_flips = largest_correct_flips }

        winners.each do |winner|
          puts "#{player.name} is a winner with #{player.correct_flips} correct flips"
        end
      end
    end

    def game_over?
      @board.grid.flatten.all? { |card| !card.hidden? }
    end

    def switch_players!
      players.rotate!(1)
      @current_player = players.first
    end

    def game_setup
      begin
        puts "How many player(s)?"
        number = gets.chomp.to_i
        raise NotEnoughPlayersError if number < 1
      rescue NotEnoughPlayersError
        puts "You must play with at least 1 player!"
        retry
      end

      number.times do |i|
        puts "Enter your name!"
        name = gets.chomp
        players << Player.new(name)
      end

      begin
        puts "How big do you want your board?"
        number = gets.chomp.to_i
        raise InvalidBoardSizeError if number < 2
      rescue InvalidBoardSizeError
        puts "You need a board of at least 2 x 2!"
        retry
      end

      @current_player = players.first
      @board = Board.new(number)
      system 'clear'
      board.display
    end

    def handle_turn
      first_flip = @last_turn.shift
      second_flip = @last_turn.shift

      if board[first_flip].matches?(board[second_flip])
        @current_player.add_correct_flip
      else
        board[first_flip].flip!
        board[second_flip].flip!
      end
    end
end

class NotEnoughPlayersError < StandardError
end

class InvalidMoveError < StandardError
end

class InvalidBoardSizeError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play_game
end
