require_relative './board'
require 'YAML'

class MineSweeper

  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    @board.display
    until won?
      select_tile
      @board.display
    end
  end

  private

    def won?
      @board.count == 10
    end

    def lose
      @board.grid.each_with_index do |row, i|
        row.each_with_index do |tile, j|
          if tile.bomb?
            @board.grid[i][j].show
          end
        end
      end

      @board.display
      puts "You lose!"
      sleep 5
      Kernel.abort
    end

    def save_game
      puts "Enter filename:"
      file = gets.chomp

      File.open(file, "w") { |f| f.write(self.to_yaml) }
      Kernel.abort("Your game has been saved!")
    end

    def select_tile
      puts "What would you like to do? Reveal(r), flag(f), save(s)"
      mode = gets.chomp

      if mode == "s"
        save_game
      end

      puts "Which node? (row, col)"
      pos = gets.chomp.split(", ").map(&:to_i)

      raise if pos.length != 2 || pos.any? { |num| !num.between?(0, 8) }
      lose if @board[pos].bomb? && mode == "r"

      if mode == "r"
        @board.reveal(pos)
      elsif mode == "f"
        @board.flag(pos)
      else
        raise
      end
    end

end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    game = MineSweeper.new
    game.play
  else
    file = ARGV.shift
    saved_game = YAML.load_file(file)
    saved_game.play
  end
end
