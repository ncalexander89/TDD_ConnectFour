# frozen_string_literal: true

require_relative '../lib/connectfour'

describe Game do
  let(:game) { Game.new }
  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
  end
  describe 'Player Win' do
    context ('When a player has four in a row') do
      it ('Displays player as the winner and ends the game') do
        allow(game).to receive(:puts).with('Player 1 Wins!')
        expect(game.player_win).to be true
      end
    end
  end
end