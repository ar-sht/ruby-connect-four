class Board
  def initialize(board = Array.new(7) { Array.new(6) })
    @board = board
  end

  def place_piece(column_index, player)
    column = @board[column_index]
    column.each_with_index { |slot, i| return column[i] = player.zero? ? "\u25CF" : "\u25CB" if slot.nil? }
  end

  def column_full?(column_index)
    column = @board[column_index]
    column.none?(&:nil?)
  end
end
