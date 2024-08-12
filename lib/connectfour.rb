# frozen_string_literal: true

# connectfour.rb

require 'pry'

class Game # rubocop:disable Style/Documentation
  attr_accessor :array, :turn

  def initialize
    @array = (Array.new(6) { Array.new(7, '.') })
    @turn = 1
  end

  def check_win
    6.times do |i| # Iterate over rows
      4.times do |j| # Iterate over columns
        @horizontal = @array[i][j], @array[i][j + 1], @array[i][j + 2], @array[i][j + 3]
        if @horizontal.all?('x') || @horizontal.all?('o')
          player_win
          return true
        end
      end
    end

    7.times do |j|
      3.times do |i|
        @vertical = @array[i][j], @array[i + 1][j], @array[i + 2][j], @array[i + 3][j]
        if @vertical.all?('x') || @vertical.all?('o')
          player_win
          return true
        end
      end
    end

    4.times do |j|
      3.times do |i|
        @diagonal_pos = @array[i][j], @array[i + 1][j + 1], @array[i + 2][j + 2], @array[i + 3][j + 3]
        if @diagonal_pos.all?('x') || @diagonal_pos.all?('o')
          player_win
          return true
        end
      end
    end

    3.times do |i|
      6.downto(3) do |j|
        @diagonal_neg = @array[i][j], @array[i + 1][j - 1], @array[i + 2][j - 2], @array[i + 3][j - 3]
        if @diagonal_neg.all?('x') || @diagonal_neg.all?('o')
          player_win
          return true
        end
      end
    end

    false
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
    i = 0
    i += 1 while array[i][@selection - 1] != '.'
    if @turn.odd?
      array[i][@selection - 1] = 'x'
    elsif @turn.even?
      array[i][@selection - 1] = 'o'
    end
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
      if input.match?(/^\d$/) && (1..7).include?(input.to_i)
        @selection = input.to_i
        return @selection
      else
        puts 'Enter a valid number'
      end
    end
  end

  def game_play
    board
    loop do
      player_turn
      board_update
      board
      # check_win
      return if check_win || draw

      @turn += 1
    end
  end
end



