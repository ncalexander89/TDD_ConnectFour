# frozen_string_literal: true

require_relative '../lib/connectfour'

describe Game do # rubocop:disable Metrics/BlockLength
  let(:game) { Game.new }

  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
  end

  describe 'Check Win' do
    let(:array) do
      [
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', 'x', 'x', 'x', 'x']
      ]
    end

    before do
      game.instance_variable_set(:@array, array) # Set the game board
      allow(game).to receive(:player_win).and_return(true)
      game.instance_variable_set(:@turn, 1)
    end

    context('When a player 1 has four in a row horizontally') do
      it('Checks the win') do
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
    end
    describe 'Board Update' do
      context('When player enters valid input') do
        it('Updates board with players 1s mark') do
          game.instance_variable_set(:@turn, 1)
          game.instance_variable_set(:@selection, 1)
          game.board_update
          expect(game.array[0][0]).to eq('x')
        end
        it('Updates board with players 2s mark') do
          game.instance_variable_set(:@turn, 2)
          game.instance_variable_set(:@selection, 2)
          game.board_update
          expect(game.array[0][1]).to eq('o')
        end
      end
    end
  end
end
