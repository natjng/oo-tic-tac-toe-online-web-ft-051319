# rspec spec/01_tic_tac_toe_spec.rb
# rspec spec/02_play_spec.rb
# rspec spec/03_cli_spec.rb

require 'pry'

class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
  
  # def initialize
  #   @board = Array.new(9, " ")
  # end
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    index = input.to_i - 1
  end
  
  def move(index, current_player = "X")
    @board[index] = current_player
  end
  
  def position_taken?(index)
    @board[index] == " " ? false : true
  end
  
  def valid_move?(index)
    index.between?(0,8) && position_taken?(index) == false ? true : false
  end
  
  def turn
    puts "Choose a position between 1-9"
    input = gets.strip
    index = input_to_index(input)
    valid_move?(index) ? move(index, current_player) : turn
    display_board
  end
  
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def won?
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]]
        return combo
      end
    end 
    # check if all indexes of the possible winning combination on the board are either all Xs or all Os
    # any will return true for any combos. if true, return combo indexes array
  end
  
  def full?
    @board.all? {|space| space != " "}
  end
  
  def draw?
    full? && (won? == false)
  end
  
  def over?
    won? || draw?
  end
  
  def winner
    if won? != false 
      @board[won?[0]]
    end
  end
  
  def play
    turn until over?
    if winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end