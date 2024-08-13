# frozen_string_literal: true

# connectfour.rb

require_relative 'check_win'
require_relative 'board'

require 'pry'

class Game # rubocop:disable Style/Documentation
  attr_accessor :array, :turn, :board, :selection

  def initialize
    @array = (Array.new(6) { Array.new(7, '.') }) # First row at the top
    @turn = 1
    @board = Board.new(@array) # Initialises board class with @array
    @selection = nil
  end

  def check_win
    checker = Check.new(@array, self) # Create an instance of Check with self being the game instance
    [checker.check_horizontal, checker.check_vertical, checker.check_diagonal_pos, checker.check_diagonal_neg].any?
  end

  def player_win
    @player = @turn.odd? ? 1 : 2
    puts "Player #{@player} Wins!"
    true
  end

  def draw
    return unless @turn == 42

    puts 'Draw Game!'
    true
  end

  def player_turn # rubocop:disable Metrics/MethodLength
    @player = @turn.odd? ? 1 : 2
    puts "Player #{@player} select your column"
    loop do
      input = gets.chomp
      # Input match single digit from 1 to 7 and available position
      if input.match?(/^\d$/) && (1..7).include?(input.to_i) && @array[5][input.to_i - 1] == '.'
        @selection = input.to_i
        return @selection
      else
        puts 'Enter a valid number'
      end
    end
  end

  def game_play
    @board.game_board
    loop do
      player_turn
      @board.board_update(turn, selection)
      @board.game_board
      return if check_win || draw

      @turn += 1
    end
  end
end
