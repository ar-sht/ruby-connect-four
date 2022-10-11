require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    # sets instance variables
  end

  describe '#play' do
    subject(:game) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    context 'when the game is over' do
      before do
        allow(game).to receive(:over?).and_return(true)
      end

      it 'ends the game and prints the exit message' do
        expect(game).to receive(:display_welcome).once
        expect(game).to receive(:over?).once
        expect(game).not_to receive(:make_move)
        expect(game).to receive(:display_result).once
        game.play
      end
    end

    context 'when the game is not over initially, but ends after one turn' do
      before do
        allow(game).to receive(:over?).and_return(false, true)
      end

      it 'gets one guess then ends and prints the exit message' do
        expect(game).to receive(:display_welcome).once
        expect(game).to receive(:over?).twice
        expect(game).to receive(:make_move).once
        expect(game).to receive(:display_status).once
        expect(game).to receive(:display_result).once
        game.play
      end
    end
  end

  describe '#display_welcome' do
    subject(:game) { described_class.new }
    let(:board) { instance_double(Board) }

    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:sleep)
    end

    it 'sends all messages it needs to' do
      expect(board).to receive(:place_piece).exactly(4).times
      expect(board).to receive(:pretty_print).exactly(3).times
      game.display_welcome(board)
    end
  end

  describe '#over?' do
    subject(:game) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    context 'when game has been won' do
      before do
        allow(board).to receive(:won?).and_return(true)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'sends requests and returns true' do
        expect(board).to receive(:won?)
        result = game.over?
        expect(result).to be true
      end
    end

    context 'when board is full' do
      before do
        allow(board).to receive(:won?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it 'sends requests and returns true' do
        expect(board).to receive(:full?)
        result = game.over?
        expect(result).to be true
      end
    end

    context 'when the game hasn\'t been won and the board isn\'t full' do
      before do
        allow(board).to receive(:won?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'sends requests and returns false' do
        expect(board).to receive(:full?)
        expect(board).to receive(:won?)
        result = game.over?
        expect(result).to be false
      end
    end
  end

  describe '#display_status' do
    subject(:game) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    before do
      allow(game).to receive(:puts)
    end

    it 'sends request to display board' do
      expect(board).to receive(:pretty_print)
      game.display_status
    end
  end

  describe '#make_move' do
    subject(:game) { described_class.new }

    context 'when given valid input' do
      before do
        valid_input = '3'
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'updates the board' do
        expect { game.make_move }.to change { game.instance_variable_get(:@board).instance_variable_get(:@board)[2][0] }.to "\u25CF"
      end
    end

    context 'when given invalid then valid input' do
      before do
        letter = 'a'
        valid_input = '3'
        allow(game).to receive(:gets).and_return(letter, valid_input)
      end

      it 'asks again then updates with the valid input' do
        error_message = 'Invalid input. Please try again:'
        expect(game).to receive(:puts).with(error_message).once
        expect { game.make_move }.to change { game.instance_variable_get(:@board).instance_variable_get(:@board)[2][0] }.to "\u25CF"
      end
    end

    context 'when given valid input but for a full column then valid input' do
      before do
        6.times do
          game.instance_variable_get(:@board).place_piece(2, 1)
        end
        valid_but_full_input = '3'
        valid_input = '4'
        allow(game).to receive(:gets).and_return(valid_but_full_input, valid_input)
      end

      it 'asks again then updates with the fully valid input' do
        error_message = 'Invalid input. Please try again:'
        expect(game).to receive(:puts).with(error_message).once
        expect { game.make_move }.to change { game.instance_variable_get(:@board).instance_variable_get(:@board)[3][0] }.to "\u25CF"
      end
    end
  end

  describe '#validate_move' do
    subject(:game) { Game.new }

    context 'when given valid input' do
      it 'returns the input as an integer' do
        valid_input = '4'
        result = game.validate_move(valid_input)
        expect(result).to eq(4)
      end
    end

    context 'when given invalid input' do
      it 'returns nil' do
        invalid_input = '100'
        result = game.validate_move(invalid_input)
        expect(result).to be_nil
      end
    end
  end
end
