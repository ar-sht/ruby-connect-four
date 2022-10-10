require_relative 'board'

class Game
  def initialize(board = Board.new, turn = 0)
    @board = board
    @turn = turn
  end

  def play
    display_welcome

    until over?
      display_status
      make_guess
      @turn = (@turn + 1) % 2
    end

    display_result
  end

  def display_welcome(example_board = Board.new)
    puts color('Welcome to Connect 4!', MAGENTA, true)
    puts color('There are a few rules to know before you play.', WHITE, true)
    puts
    puts
    sleep(0.5)
    puts color("You'll see a board like this:", WHITE)
    puts
    example_board.pretty_print
    puts
    puts
    sleep(0.4)
    puts color("Then you'll enter which column you'd like to play in, say 3.", WHITE)
    sleep(0.2)
    puts color('3', WHITE)
    sleep(0.4)
    example_board.place_piece(2, 0)
    puts
    puts color('And the board will update like this:', WHITE)
    puts
    example_board.pretty_print
    puts
    puts
    sleep(0.5)
    puts color("You'll win when you - believe it or not - connect 4. You can do this in a column, diagonal, or a row, like this:", WHITE)
    sleep(0.2)
    puts
    example_board.place_piece(3, 0)
    example_board.place_piece(4, 0)
    example_board.place_piece(5, 0)
    example_board.pretty_print
  end

  def over?
    @board.full? || @board.won?
  end

  def display_status(turn = @turn)
    puts color('The board looks like this:', WHITE)
    puts
    @board.pretty_print
    puts
    puts color("Player #{turn + 1}'s turn:", WHITE)
  end

  def make_guess(turn = @turn)

  end
end
