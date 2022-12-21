require_relative '../lib/round.rb'
require_relative '../lib/board.rb'
require_relative '../helpers/board_helper.rb'
require_relative '../lib/player.rb'
require 'spec_helper'

board = TicTacToe::Board.new
round = TicTacToe::Game::Round.new(board, 'Player 1', 'Player 2')
RSpec.describe 'Player can set their name' do
  it "returns Player's name equal to instance count if no name is chosen" do
    p1 = TicTacToe::Player.new
    p2 = TicTacToe::Player.new
    expect(p1.name).to eq(1)
    expect(p2.name).to eq(2)
  end

  it "returns Player's name if set" do
    p3 = TicTacToe::Player.new
    p3.name = 'John'
    expect(p3.name).to eq('John')
  end
end

RSpec.describe 'Player wins' do
  it 'returns win if 1st row is won' do
    board.table.replace [%w[X X X], %w[. . .], %w[. . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'returns win if 2st row is won' do
    board.table.replace [%w[. . .], %w[X X X], %w[. . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'returns win if 3st row is won' do
    board.table.replace [%w[. . .], %w[. . .], %w[X X X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'returns win if left diagonal is won' do
    board.table.replace [%w[X . .], %w[. X .], %w[. . X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'returns win if right diagonal is won' do
    board.table.replace [%w[. . X], %w[. X .], %w[X . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end
end

RSpec.describe 'Players are drawn' do
  it 'returns draw if no free positions left' do
    board.table.replace [%w[X O X], %w[O X O], %w[O X O]]
    expect(round.instance_eval { check_combinations }).to eq('draw')
  end
end
