require_relative './tile'

class Board

  NUM_TILES = 81

  attr_reader :grid, :count

  def initialize
    @grid = Array.new(9) { Array.new(9) { Tile.new } }
    @count = NUM_TILES
    assign_tiles
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def display
    system("clear")
    @grid.each_with_index do |row, i|
      line = ""
      row.each_with_index do |tile, j|
        if @grid[i][j].flagged?
          line += "F | "
        elsif @grid[i][j].hidden?
          line += "_ | "
        else
          line += "#{tile.value} | "
        end
      end
      puts line
    end
  end

  def reveal(pos)
    if self[pos].has_value?
      self[pos].show
    else
      queue = [pos]
      visited_tiles = []

      until queue.empty?
        current_pos = queue.shift
        visited_tiles << current_pos

        adjacents = adjacent_positions(current_pos).reject do |pos|
          visited_tiles.include?(pos) && self[current_pos].has_value?
        end

        queue += adjacents
        self[current_pos].show
        @count -= 1
      end
    end
  end

  def flag(pos)
    self[pos].flag
  end

  private

    def adjacent_positions(pos)
      movements = [[1, 1], [0, 0], [-1, -1]] + [1, 0, -1].permutation(2).to_a

      positions = []
      movements.each do |move|
        row = move[0] + pos[0]
        col = move[1] + pos[1]
        positions << [row, col] if row.between?(0, 8) && col.between?(0, 8)
      end

      positions
    end

    def assign_tiles
      bombs = []
      until bombs.count == 10
        row = rand(9)
        col = rand(9)
        pos = [row, col]
        bombs << pos unless bombs.include?(pos)
      end

      bombs.each do |bomb|
        row, col = bomb
        self[bomb].set_to_bomb
        adjacent_positions(bomb).each do |adjacent|
          row, col = adjacent
          self[adjacent].add_value unless self[adjacent].bomb?
        end
      end
    end
end
