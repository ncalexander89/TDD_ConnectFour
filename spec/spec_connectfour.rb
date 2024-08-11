# frozen_string_literal: true

require_relative '../lib/connectfour'

describe Game do # rubocop:disable Metrics/BlockLength
  let(:game) { Game.new }
  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
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
      it('Player 2 to enter valid input') do
        allow(game).to receive(:gets).and_return('1')
        game.instance_variable_set(:@turn, 2)
        expect(game).to receive(:puts).with('Player 2 select your column')
        game.player_turn
        expect(game.instance_variable_get(:@selection)).to eq(1)
      end
    end
    describe 'Board Update' do
      context('When player enters valid input') do
        it('Updates board with players mark') do
          game.instance_variable_set(:@selection, 1)
          game.board_update
          expect(game.array[0][0]).to eq('x')
        end
      end
    end
  end
end
