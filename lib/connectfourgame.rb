# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class ConnectFourGame
  def initialize(board = Board.new, player1 = Player.new('Player 1', 'X'), player2 = Player.new('Player 2', 'O'))
    @board = board
    @player1 = player1
    @player2 = player2
    @curr_player = player1
  end

  def play_game
    # TODO:
    puts "Welcome to Connect Four!"
    @board.draw
    turn_order until game_over?
    final_message
  end

  def player_input(num_of_columns = @board.columns)
    loop do
      print "#{@curr_player.name} - choose column: "
      user_input = gets.chomp
      valid_input = verify_input(num_of_columns, user_input.to_i) if user_input.match?(/^\d+$/)
      return valid_input if valid_input

      puts 'Error'
    end
  end

  def verify_input(num_of_columns, input)
    array_index = input - 1
    return input if input.between?(1, num_of_columns) && !@board.full_column?(array_index)
  end

  def game_over?
    return true if draw? || @board.check_rows

    false
  end

  def draw?
    return true if @board.full?

    false
  end

  def turn_order
    input = player_input - 1
    @board.place_mark(input, @curr_player.mark)
    @board.draw
    @curr_player = @curr_player == @player1 ? @player2 : @player1
  end

  def final_message
    if draw?
      puts "It's a draw!"
    else
      winning_player = @board.check_rows == @player1.mark ? @player1.name : @player2.name
      puts "#{winning_player} won!"
    end

  end

end