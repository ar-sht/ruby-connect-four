class Board
  COMBOS = [
    [0, 1, 2, 3, 4, 5],
    [0, 6, 12, 18, 24, 30],
    [0, 7, 14, 21, 28, 35],
    [5, 10, 15, 20, 25, 30]
  ].freeze
  def initialize(board = Array.new(7) { Array.new(6) })
    @board = board
  end

  def pretty_print
    row_strings = []
    6.times do |row|
      row = 5 - row
      row_string = ' '
      7.times do |column|
        row_string += "\u2503 #{@board[column][row].nil? ? ' ' : @board[column][row]} "
      end
      row_string += "\u2503"
      row_strings.append(row_string)
      row_strings.append(" #{"  \u23AF " * 7}")
    end
    row_strings.append("\u002F#{' ' * 29}\u005C")
    puts row_strings.join("\n")
  end

  def place_piece(column_index, player)
    column = @board[column_index]
    column.each_with_index { |slot, i| return column[i] = player.zero? ? "\u25CF" : "\u25CB" if slot.nil? }
  end

  def column_full?(column_index)
    column = @board[column_index]
    column.none?(&:nil?)
  end

  def won?
    flat_board = @board.flatten
    7.times do |shift|
      column = []
      indexes = COMBOS[0].map { |value| value + 6 * shift }
      indexes.each do |index|
        column.append(flat_board[index])
      end
      3.times do |i|
        four = column.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?)
      end
    end

    6.times do |shift|
      row = []
      indexes = COMBOS[1].map { |value| value + shift }
      indexes.each do |index|
        row.append(flat_board[index])
      end
      4.times do |i|
        four = row.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?)
      end
    end

    5.times do |shift|
      diag1 = []
      diag2 = []

      indexes1 = COMBOS[2].map { |value| value + 2 - shift }.reject { |value| value > 35 || value.negative? || value == 5 || value == 30 }
      indexes2 = COMBOS[3].map { |value| value + 2 - shift }.reject { |value| value > 35 || value.negative? || value == 6 || value == 7 || value == 12 }

      indexes1.each do |index|
        diag1.append(flat_board[index])
      end

      indexes2.each do |index|
        diag2.append(flat_board[index])
      end

      (diag1.size - 3).times do |i|
        four = diag1.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?)
      end

      (diag2.size - 3).times do |i|
        four = diag2.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?)
      end
    end

    false
  end
end

puts

board = Board.new
5.times do |i|
  6.times do |i|
    board.place_piece(i, rand(2) % 2)
  end
end

board.pretty_print
