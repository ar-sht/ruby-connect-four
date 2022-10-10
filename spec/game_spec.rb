require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    # sets instance variables
  end

  describe '#play' do
    subject(:game) { Game.new }

    context 'when the game is over' do
      it 'ends the game and prints the exit message' do
        expect(game).to receive(:over?)
      end
    end
  end
end