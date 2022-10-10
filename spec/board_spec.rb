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

  describe '#won?' do
    context 'when game is won vertically' do
      subject(:board) { Board.new }

      before do
        6.times do
          board.place_piece(3, 0)
        end
      end

      it 'returns true' do
        result = board.won?
        expect(result).to be true
      end
    end

    context 'when game is won horizontally' do
      subject(:board) { Board.new }

      before do
        4.times do |i|
          board.place_piece(i, 0)
        end
      end

      it 'returns true' do
        result = board.won?
        expect(result).to be true
      end
    end

    context 'when game is won diagonally' do
      subject(:board) { Board.new }

      before do
        4.times do |i|
          i.times do
            board.place_piece(i, ((i % 2) + 1) % 2)
          end
          board.place_piece(i, 1)
        end
      end

      it 'returns true' do
        result = board.won?
        expect(result).to be true
      end
    end

    context 'when game is not won' do
      subject(:board) { Board.new }

      before do
        6.times do |i|
          3.times do |j|
            board.place_piece(j, ((i % 2) + (j % 2)) % 2)
          end
        end
      end

      it 'returns false' do
        result = board.won?
        expect(result).to be false
      end
    end
  end
end
