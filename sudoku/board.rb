class Board

  attr_reader :grid

  def initialize(file)
    @grid = make_grid(file)
  end

  def display
    @grid.each_with_index do |row, i|
      holder = ""
      row.each_with_index do |node, j|
        holder << " #{node.to_s} |"
      end
      puts holder.strip
      if (i + 1) % 3 == 0
        puts "_" * 35
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def []=(pos, value)
    x, y = pos
    @grid[y][x] = value
  end

  def valid_play?(pos, i = nil)
    x, y = pos
    if !x.between(0, 8) || !y.between(0, 8)
      return false
    elsif self[pos].given?
      return false
    end

    if i.nil?
      return true
    else
      row_not_contain?(i, y) && col_not_contain?(i, x) && square_not_contain?(i, pos)
    end
  end


  private

    def make_grid(file)
      grid = []
      File.open(file).each do |line|
        holder = []
        line.chomp.each_char do |tile|
          if tile == "0"
            holder << Tile.new(0)
          else
            holder << Tile.new(tile, true)
          end
        end
        grid << holder
      end
      grid
    end

    def row_not_contain?(num, row)
      !@grid[row].any? { |tile| tile.equals?(num) }
    end

    def col_not_contain?(num, col)
      @grid.each do |row|
        return false if row[col].equals?(num)
      end
      true
    end

    def square_not_contain?(num, pos)
      thirds = determine_third(pos)

      x_range, y_range = nil
      thirds.each_with_index do |third, i|
        if i == 0
          if third == 0
            x_range = [0, 2]
          elsif third == 1
            x_range = [3, 5]
          elsif third == 2
            x_range = [6, 8]
          end
        else
          if third == 0
            y_range = [0, 2]
          elsif third == 1
            y_range = [3, 5]
          elsif third == 2
            y_range = [6, 8]
          end
        end
      end

      @grid[y_range[0]..y_range[1]].each do |row|
        row[x_range[0]..x_range[1]].each do |tile|
          return false if tile.equals?(num)
        end
      end
    end

    def determine_third(pos)
      x, y = pos

      if x.between?(0, 2)
        x_third = 0
      elsif x.between?(3, 5)
        x_third = 1
      elsif x.between?(6, 8)
        x_third = 2
      end

      if y.between?(0, 2)
        y_third = 0
      elsif y.between?(3, 5)
        y_third = 1
      elsif y.between?(6, 8)
        y_third = 2
      end

      [x_third, y_third]
    end

end
