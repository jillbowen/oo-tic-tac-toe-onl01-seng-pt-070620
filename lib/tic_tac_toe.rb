
require 'pry'

class TicTacToe
  attr_accessor :board
  
  def initialize
    @board = Array.new(9, " ")
  end
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2] 
  ]
    
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1 
  end
  
  def move(index, token)
    @board[index] = token
  end
  
  def position_taken?(index)
    if @board[index] == " " 
      false  
    else 
      true  
    end
  end
  
  def valid_move?(index)
    if index.between?(0,8) && @board[index] == " "
      true
    else
      false
    end
  end
  
  def turn_count
    counter = 0 
    board.each do |square|
      if square == "X" || square == "O"
      counter +=1
      end
    end
    counter
  end
  
  def current_player
    if turn_count.even?
      "X"
    else turn_count.odd?
      "O"
    end
  end
  
  def turn 
    puts "Player, please enter 1-9:"
    user_input = gets
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      turn
    else
      puts "Invalid selection, please choose again:"
      user_input = gets
    end
    display_board
  end
  
#   def turn(board)
#   puts "Please enter 1-9:"
#   user_input = gets.strip
#   index = input_to_index(user_input)
#   if valid_move?(board, index)
#       move(board, index, current_player(board))
#       turn(board)
#   end
#   display_board(board)
# end
  
  def won?
    WIN_COMBINATIONS.each do |combo|
      #binding.pry
      if ("X" == @board[combo[0]] && "X" == @board[combo[1]] && "X" == @board[combo[2]]) || ("O" == @board[combo[0]] && "O" == @board[combo[1]] && "O" == @board[combo[2]])
        return combo
      end
    end
    false 
  end
  
  def full?
    @board.all?{|square| square == "X" || square == "O"}
  end
  
  def draw?
    if !won? && full?
      true 
    elsif won?
      false
    else !won? && !full?
      false
    end
  end
  
  def over?
    if won? || draw? || full?
     return true
    end
    false 
  end
  
  def winner
    if won?
      return board[won?[0]]
   end
  end
  
  def play
    until over?
      turn
    end
    
    if won?
      winner == "X" || winner == "O" 
        puts "Congratulations #{winner}!" 
    elsif draw?
        puts "Cat's Game!" 
    end
  end
  
end