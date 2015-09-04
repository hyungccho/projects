require_relative './board'
require_relative './tile'

class Game

  attr_reader :board

  def initialize(file)
    @board = Board.new(file)
  end

  def run
    until won?
      begin
        @board.display
        choose_tile
      rescue
        puts $!.message
        retry
      end
    end
    puts "\nCongratulations, you won the game!"
  end

  private

  def make_change(pos)
    puts "What number do you want to change it to?"
    num = gets.chomp.to_i

    if @board.valid_play?(pos, num) && (1..9).include?(num)
      @board[pos].value = num
    else
      raise "\nNot a valid move!"
    end
  end

  def choose_tile
    puts "Which tile do you want to change?"
    pos = gets.chomp.split(", ").map(&:to_i)

    if @board.valid_play?(pos)
      make_change(pos)
    else
      raise "\nInvalid position!"
    end
  end

  def won?
    winning_rows? && winning_cols? && winning_squares?
  end

  def winning_rows?
    ideal = (1..9).to_a.map(&:to_s)

    @board.grid.each do |row|
      holder = []
      row.each do |tile|
        holder << tile.to_s
      end
      return false if holder.sort != ideal
    end
    true
  end

  def winning_cols?
    ideal = (1..9).to_a.map(&:to_s)

    9.times do |i|
      holder = []
      @board.grid.each do |row|
        holder << row[i].to_s
      end

      return false if holder.sort != ideal
    end
    true
  end

  def winning_squares?
    ideal = (1..9).to_a.map(&:to_s)

    i = 0
    while i < 9
      j = 0
      while j < 9
        holder = []
        @board.grid[i..(i + 2)].each do |row|
          row[j..(j + 2)].each do |tile|
            holder << tile.to_s
          end
        end

        return false if holder.sort != ideal
        j += 3
      end
      i += 3
    end
    true
  end
end

if __FILE__ == $PROGRAM_NAME
  new_game = Game.new("./puzzles/sudoku.txt")
  new_game.run
end
