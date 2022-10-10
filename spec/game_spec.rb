require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    # sets instance variables
  end

  describe '#play' do
    subject(:game) { Game.new }

    context 'when the game is over' do
      before do
        allow(game).to receive(:over?).and_return(false)
      end

      it 'ends the game and prints the exit message' do
        expect(game).to receive(:display_welcome)
        expect(game).to receive(:over?)
        expect(game).not_to receive(:make_guess?)
        expect(game).to receive(:display_result)
        game.play
      end
    end
  end

  describe '#display_welcome' do
    subject(:game) { Game.new }
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
    subject(:game) { Game.new(board) }
    let(:board) { instance_double(Board) }

    context 'when game has been won' do
      before do
        allow(board).to receive(:won?).and_return(true)
        allow(board).to receive(:full?)
      end

      it 'returns true' do
        expect(board).to receive(:won?).and_return(true)
        result = game.over?
        expect(result).to be true
      end
    end
  end
end