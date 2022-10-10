require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    # sets instance variables
  end

  describe '#place_piece' do
    subject(:board) { Board.new }

    context 'when given valid input on an empty column' do
      it 'places the piece on the bottom of the correct row' do
        valid_column = 3
        current_board = board.instance_variable_get(:@board)
        expect { board.place_piece(valid_column, 0) }.to change { current_board[3][0] }.to "\u25CF"
      end
    end

    context 'when given valid input on a partly-populated column' do
      before do
        board.place_piece(3, 0)
      end

      it 'places the piece in the lowest unoccupied space' do
        used_column = 3
        current_board = board.instance_variable_get(:@board)
        expect { board.place_piece(used_column, 1) }.to change { current_board[3][1] }.to "\u25CB"
      end
    end
  end

  describe '#column_full?' do
    subject(:board) { Board.new }

    context 'when column is not full' do
      it 'returns false' do
        not_full_column = 3
        result = board.column_full?(not_full_column)
        expect(result).not_to be true
      end
    end

    context 'when column is full' do
      before do
        6.times do |i|
          board.place_piece(3, i % 2)
        end
      end

      it 'returns true' do
        full_column = 3
        result = board.column_full?(full_column)
        expect(result).to be true
      end
    end
  end
end
