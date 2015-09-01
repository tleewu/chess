class Knight < Piece

  POSSIBLE_CHANGES = [[1,2], [2,1],[-1,2], [-2,-1], [-2,1], [1,-2], [-1,-2], [-2,-1]]

  def initialize(position, board)
    @mark = " N "
    @position = position
    @board = board
  end

  def moves
    possible_moves = []
    x, y = @position
    POSSIBLE_CHANGES.each do |change|
      update_position = [change[0]+x,change[1]+y]
      possible_moves << update_position if update_position.max < 8 && update_position.min >= 0
    end
    possible_moves
  end

  def valid_move?(pos)
    moves.include?(pos)
  end

end
