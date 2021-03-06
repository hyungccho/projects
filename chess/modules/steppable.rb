module Steppable
  DIRECTIONS = { up: [0, -1],
                 down: [0, 1],
                 left: [-1, 0],
                 right: [1, 0],
                 upright: [1, -1],
                 upleft: [-1, -1],
                 downright: [1, 1],
                 downleft: [-1, 1] }

  def get_possible_moves
    result = []
    available_directions.each do |dir|
      new_pos = [@pos[0] + DIRECTIONS[dir][0], @pos[1] + DIRECTIONS[dir][1]]
      result << new_pos if @board.valid_move?(@pos, new_pos)
    end
    result
  end
end
