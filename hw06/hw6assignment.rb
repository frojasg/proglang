# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],
                   rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                   [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                   [[0, 0], [0, -1], [0, 1], [0, 2]]],
                   rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                   rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                   rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                   rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]),
                   [[[0, 0], [-1, 0], [1, 0], [2, 0], [3, 0]], # extra #2 very long (only needs two)
                   [[0, 0], [0, -1], [0, 1], [0, 2], [0, 3]]],
                   rotations([[0, 0], [1, 0], [0, -1], [0, 1], [1, 1]]), # extra #1
                   rotations([[0,0], [0,1], [1,0]]) #extra #3
                  ]

  def self.next_piece(board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
end

class MyBoard < Board

  def initialize(game)
    super
    @current_block = MyPiece.next_piece(self)
  end

  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    locations.each_with_index do |current, index|
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
      @current_pos[index]
    end
    remove_filled
    @delay = [@delay - 2, 80].max
  end

end

class MyTetris < Tetris

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    @root.bind('u', proc { 2.times { @board.rotate_clockwise } })
    super
  end
end


