# frozen_string_literal: true

# check_win.rb

require_relative 'connectfour'

class Board # rubocop:disable Style/Documentation
  attr_accessor :array # Add an accessor for @array

  def initialize(array)
    @array = array
  end

  def game_board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
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

  def board_update(turn, selection)
    i = 0
    i += 1 while array[i][selection - 1] != '.'
    if turn.odd?
      array[i][selection - 1] = 'x'
    elsif turn.even?
      array[i][selection - 1] = 'o'
    end
  end
end
