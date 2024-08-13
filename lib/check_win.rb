# frozen_string_literal: true

# check_win.rb

require_relative 'connectfour'

class Check # rubocop:disable Style/Documentation
  attr_accessor :array, :game_instance

  def initialize(array, game_instance)
    @array = array
    @game_instance = game_instance # Store the Game instance
  end

  def check_horizontal
    6.times do |i| # Iterate over rows
      4.times do |j| # Iterate over columns
        @horizontal = @array[i][j], @array[i][j + 1], @array[i][j + 2], @array[i][j + 3]
        if @horizontal.all?('x') || @horizontal.all?('o')
          @game_instance.player_win
          return true
        end
      end
    end
    false
  end

  def check_vertical
    7.times do |j|
      3.times do |i|
        @vertical = @array[i][j], @array[i + 1][j], @array[i + 2][j], @array[i + 3][j]
        if @vertical.all?('x') || @vertical.all?('o')
          @game_instance.player_win
          return true
        end
      end
    end
    false
  end

  def check_diagonal_pos # rubocop:disable Metrics/AbcSize
    4.times do |j|
      3.times do |i|
        @diagonal_pos = @array[i][j], @array[i + 1][j + 1], @array[i + 2][j + 2], @array[i + 3][j + 3]
        if @diagonal_pos.all?('x') || @diagonal_pos.all?('o')
          @game_instance.player_win
          return true
        end
      end
    end
    false
  end

  def check_diagonal_neg # rubocop:disable Metrics/AbcSize
    3.times do |i|
      6.downto(3) do |j|
        @diagonal_neg = @array[i][j], @array[i + 1][j - 1], @array[i + 2][j - 2], @array[i + 3][j - 3]
        if @diagonal_neg.all?('x') || @diagonal_neg.all?('o')
          @game_instance.player_win
          return true
        end
      end
    end
    false
  end
end
