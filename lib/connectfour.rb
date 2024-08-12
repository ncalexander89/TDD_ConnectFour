# frozen_string_literal: true

# connectfour.rb

require_relative 'check_win' # Make sure this points to the right file
require_relative 'board' # Add this line to require the Board class

require 'pry'

class Game # rubocop:disable Style/Documentation
  attr_accessor :array, :turn, :board

  def initialize
    @array = (Array.new(6) { Array.new(7, '.') })
    @turn = 1
    @board = Board.new(@array) # Create an instance of Board
  end

  def check_win
    checker = Check.new(@array, self) # Create an instance of Check
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
      @board.board_update(turn, @selection)
      @board.game_board
      return if check_win || draw

      @turn += 1
    end
  end
end
