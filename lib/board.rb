require_relative 'color'

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
      row_strings.append(color(row_string, CYAN))
      row_strings.append(color(" #{"  \u23AF " * 7}", CYAN))
    end
    num_row = ''
    7.times { |i| num_row += "  #{i + 1} "}
    row_strings.append(color("\u002F#{num_row} \u005C", CYAN))
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

  def full?
    @board.all? { |column| column_full?(@board.index(column)) }
  end

  def won?
    flat_board = @board.flatten
    7.times do |shift|
      column = []
      indexes = COMBOS[0].map { |value| value + 6 * shift }
      indexes.each do |index|
        column.append(flat_board[index])
      end
      2.times do |i|
        four = column.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?) && four.size == 4
      end
    end

    6.times do |shift|
      row = []
      indexes = COMBOS[1].map { |value| value + shift }
      indexes.each do |index|
        row.append(flat_board[index])
      end
      3.times do |i|
        four = row.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?) && four.size == 4
      end
    end

    6.times do |shift|
      diag1 = []
      diag2 = []

      indexes1 = COMBOS[2].map { |value| value + 2 - shift }.reject { |value| value > 35 || value.negative? || value == 5 || value == 30 || value == 17 || value == 11 }
      indexes2 = COMBOS[3].map { |value| value + 2 - shift }.reject { |value| value > 35 || value.negative? || value == 6 || value == 7 || value == 12 }

      indexes1.each do |index|
        diag1.append(flat_board[index])
      end

      indexes2.each do |index|
        diag2.append(flat_board[index])
      end

      (diag1.size - 4).times do |i|
        four = diag1.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?) && four.size == 4
      end

      (diag2.size - 4).times do |i|
        four = diag2.slice(i, 4)
        return true if four.uniq.size == 1 && four.none?(&:nil?) && four.size == 4
      end
    end

    false
  end
end
