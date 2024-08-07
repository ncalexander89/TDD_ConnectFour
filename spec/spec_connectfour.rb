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
        player = 1
        allow(game).to receive(:puts).with("Player '#{player}' Wins!")
        expect(game.player_win(player)).to be true
      end
      it('Displays player 2 as the winner and ends the game') do
        player = 2
        allow(game).to receive(:puts).with("Player '#{player}' Wins!")
        expect(game.player_win(player)).to be true
      end
    end
  end
  describe 'Draw Game' do
    context('When there are no more spaces left') do
      it('Draw Game and ends the game') do
        allow(game).to receive(:puts).with('Draw Game!')
        expect(game.draw).to be true
      end
    end
  end
  describe 'Player Turn' do
    context('When players turn') do
      it('Player 1 to enter valid input') do
        allow(game).to receive(:gets).and_return('5')
        player = 1
        expect(game).to receive(:puts).with("Player '#{player}' select your column")
        input_selection = game.player_turn
        expect(input_selection).to eq(5)
      end
      it('Player 2 to enter valid input') do
        allow(game).to receive(:gets).and_return('1')
        player = 1
        expect(game).to receive(:puts).with("Player '#{player}' select your column")
        input_selection = game.player_turn
        expect(input_selection).to eq(1)
      end
    end
    # describe 'Board Update' do
    #   context('When player enters valid input') do
    #     it('Updates board with players mark') do
    #       expect(game.array[0][1]).to eq('x')
    #     end
    #   end
    # end
  end
end
