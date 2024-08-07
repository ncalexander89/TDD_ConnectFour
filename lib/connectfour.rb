# frozen_string_literal: true

# connectfour.rb

class Game # rubocop:disable Style/Documentation
  attr_accessor :array, :turn

  def initialize
    @array = Array.new(6) { Array.new(7, '.') }
    @turn = 1
  end

  def player_win
    @player = @turn.odd? ? 1 : 2
    puts "Player #{@player} Wins!"
    true
  end

  def board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts "
  1   2   3   4   5   6   7
-----------------------------
| #{@array[5][0]} | #{@array[5][1]} | #{@array[5][2]} | #{@array[5][3]} | #{@array[5][4]} | #{@array[5][5]} | #{@array[5][6]} |
-----------------------------
| #{@array[4][0]} | #{@array[4][1]} | #{@array[4][2]} | #{@array[4][3]} | #{@array[4][4]} | #{@array[4][5]} | #{@array[4][6]} |
-----------------------------
| #{@array[3][0]} | #{@array[3][1]} | #{@array[3][2]} | #{@array[3][3]} | #{@array[3][4]} | #{@array[3][5]} | #{@array[3][6]} |
-----------------------------
| #{@array[2][0]} | #{@array[2][1]} | #{@array[2][2]} | #{@array[2][3]} | #{@array[2][4]} | #{@array[2][5]} | #{@array[2][6]} |
-----------------------------
| #{@array[1][0]} | #{@array[1][1]} | #{@array[1][2]} | #{@array[1][3]} | #{@array[1][4]} | #{@array[1][5]} | #{@array[1][6]} |
-----------------------------
| #{@array[0][0]} | #{@array[0][1]} | #{@array[0][2]} | #{@array[0][3]} | #{@array[0][4]} | #{@array[0][5]} | #{@array[0][6]} |
-----------------------------
  "
  end

  def board_update
    array[0][@selection - 1] = 'x' if array[0][@selection - 1] == '.'
  end

  def draw
    puts 'Draw Game!'
    true
  end

  def player_turn
    @player = @turn.odd? ? 1 : 2
    puts "Player #{@player} select your column"
    gets.chomp.to_i
  end

  def game_play
    board
    player_turn
    board_update
    board
  end
end

# start = Game.new
# start.game_play

