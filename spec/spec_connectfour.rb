# frozen_string_literal: true

require_relative '../lib/connectfour'
require_relative '../lib/check_win'
require_relative '../lib/board'

describe Game do # rubocop:disable Metrics/BlockLength
  let(:game) { Game.new }

  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
  end

  describe Check do # rubocop:disable Metrics/BlockLength
    let(:check) { Check.new(array, game) }

    before do
      allow(check).to receive(:puts) # Avoid actual printing to console
      allow(game).to receive(:player_win).and_return(true) # Mock player_win to avoid printing
      game.instance_variable_set(:@array, array.reverse!) # Set the game board
    end

    context('When a player has four in a row horizontally') do
      let(:array) do
        [
          ['.', '.', '.', 'x', 'x', 'x', 'x'],
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.']
        ]
      end

      it('Checks the win') do
        expect(check.check_horizontal).to be true
        expect(game.check_win).to be true
      end
    end

    context('When a player has four in a row vertically') do
      let(:array) do
        [
          ['.', '.', '.', '.', '.', '.', 'o'],
          ['.', '.', '.', '.', '.', '.', 'o'],
          ['.', '.', '.', '.', '.', '.', 'o'],
          ['.', '.', '.', '.', '.', '.', 'o'],
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.']
        ]
      end

      it('Checks the win') do
        expect(check.check_vertical).to be true
        expect(game.check_win).to be true
      end
    end

    context('When a player has four in a row diagonally positive') do
      let(:array) do
        [
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', 'x', '.'],
          ['.', '.', '.', '.', 'x', '.', '.'],
          ['.', '.', '.', 'x', '.', '.', '.'],
          ['.', '.', 'x', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.']
        ]
      end

      it('Checks the win') do
        expect(check.check_diagonal_pos).to be true
        expect(game.check_win).to be true
      end
    end

    context('When a player has four in a row diagonally negative') do
      let(:array) do
        [
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', 'x', '.', '.', '.', '.', '.'],
          ['.', '.', 'x', '.', '.', '.', '.'],
          ['.', '.', '.', 'x', '.', '.', '.'],
          ['.', '.', '.', '.', 'x', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.']
        ]
      end

      it('Checks the win') do
        expect(check.check_diagonal_neg).to be true
        expect(game.check_win).to be true
      end
    end
  end

  describe 'Player Win' do
    context('When a player has four in a row') do
      it('Displays player 1 as the winner and ends the game') do
        game.instance_variable_set(:@turn, 1)
        allow(game).to receive(:puts).with('Player 1 Wins!')
        expect(game.player_win).to be true
      end
      it('Displays player 2 as the winner and ends the game') do
        game.instance_variable_set(:@turn, 2)
        allow(game).to receive(:puts).with('Player 2 Wins!')
        expect(game.player_win).to be true
      end
    end
  end

  describe 'Draw Game' do
    context('When there are no more spaces left') do
      it('Draw Game and ends the game') do
        allow(game).to receive(:puts).with('Draw Game!')
        game.instance_variable_set(:@turn, 42)
        expect(game.draw).to be true
      end
    end
  end

  describe 'Player Turn' do # rubocop:disable Metrics/BlockLength
    before do
      game.instance_variable_set(:@array, array.reverse) # Set the game board
    end
    let(:array) do
      [
        ['x', '.', '.', '.', '.', '.', '.'],
        ['x', '.', '.', '.', '.', '.', '.'],
        ['x', '.', '.', '.', '.', '.', '.'],
        ['x', '.', '.', '.', '.', '.', '.'],
        ['x', '.', '.', '.', '.', '.', '.'],
        ['x', '.', '.', '.', '.', '.', '.']
      ]
    end
    context('When players turn') do
      it('Player 1 to enter invalid input then valid input') do
        allow(game).to receive(:gets).and_return('a', '5')
        game.instance_variable_set(:@turn, 1)
        expect(game).to receive(:puts).with('Player 1 select your column')
        expect(game).to receive(:puts).with('Enter a valid number')
        expect(game.player_turn).to eq(5)
        expect(game.instance_variable_get(:@selection)).to eq(5)
      end
      it('Player 2 to enter invalid input then valid input') do
        allow(game).to receive(:gets).and_return('b', '4')
        game.instance_variable_set(:@turn, 2)
        expect(game).to receive(:puts).with('Player 2 select your column')
        expect(game).to receive(:puts).with('Enter a valid number')
        expect(game.player_turn).to eq(4)
        expect(game.instance_variable_get(:@selection)).to eq(4)
      end
      it('Player enters column number with no spaces left') do
        allow(game).to receive(:gets).and_return('1', '6')
        game.instance_variable_set(:@turn, 1)
        expect(game).to receive(:puts).with('Player 1 select your column')
        expect(game).to receive(:puts).with('Enter a valid number')
        expect(game.player_turn).to eq(6)
        expect(game.instance_variable_get(:@selection)).to eq(6)
      end
    end
  end

  describe 'Board Update' do # rubocop:disable Metrics/BlockLength
    let(:board) { Board.new(array) }
    let!(:array) do
      [
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.']
      ]
    end
    before do
      game.instance_variable_set(:@array, array)
    end
    context('When player enters valid input') do
      it('Updates board with players 1s mark') do
        game.instance_variable_set(:@turn, 1)
        game.instance_variable_set(:@selection, 1)
        board.board_update(game.instance_variable_get(:@turn), game.instance_variable_get(:@selection))
        expect(game.array[0][0]).to eq('x')
      end
      it('Updates board with players 2s mark') do
        game.instance_variable_set(:@turn, 2)
        game.instance_variable_set(:@selection, 2)
        board.board_update(game.instance_variable_get(:@turn), game.instance_variable_get(:@selection))
        expect(game.array[0][1]).to eq('o')
      end
    end
  end
end
