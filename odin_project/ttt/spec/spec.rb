require 'spec_helper'
require 'io/console'

require_relative '../lib/round.rb'
require_relative '../lib/board.rb'
require_relative '../helpers/board_helper.rb'
require_relative '../lib/player.rb'
require_relative '../lib/game.rb'

board = TicTacToe::Board.new
p1 = TicTacToe::Player.new
p2 = TicTacToe::Player.new
round = TicTacToe::Game::Round.new(board, p1, p2)

RSpec.describe 'Player can set their name' do
  it "Player's name is set to instance count if no name is chosen" do
    expect(p1.name).to eq(1)
    expect(p2.name).to eq(2)
  end

  it "Player's name can be set to a desired name" do
    p1.name = 'John'
    expect(p1.name).to eq('John')
  end
end

RSpec.describe 'Validates position entered by Player' do
  board.set(0, 0, 'X')

  it "position is valid if Player's input is between 1-9" do
    position = p1.make_move(board.table, 2)
    expect(!!round.instance_eval { not_valid?(position) }).to eq(false)
  end

  it "position is NOT valid if Player's input is out of 1-9 range" do
    position = p1.make_move(board.table, 100)
    expect(!!round.instance_eval { not_valid?(position) }).to eq(true)
  end

  it "position is NOT valid if Player's input is unexpected" do
    position = p1.make_move(board.table, 'one')
    expect(!!round.instance_eval { not_valid?(position) }).to eq(true)
  end

  it 'position is NOT valid if position is already taken' do
    position = p1.make_move(board.table, 1)
    expect(!!round.instance_eval { not_valid?(position) }).to eq(true)
  end
end

RSpec.describe 'Player wins' do
  it 'win if 1st row is won' do
    board.table.replace [%w[X X X], %w[. . .], %w[. . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'win if 2st row is won' do
    board.table.replace [%w[. . .], %w[X X X], %w[. . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'win if 3st row is won' do
    board.table.replace [%w[. . .], %w[. . .], %w[X X X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'win if left diagonal is won' do
    board.table.replace [%w[X . .], %w[. X .], %w[. . X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'win if right diagonal is won' do
    board.table.replace [%w[. . X], %w[. X .], %w[X . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end
end

RSpec.describe 'Players are drawn' do
  it 'draw if no free positions left' do
    board.table.replace [%w[X O X], %w[O X O], %w[O X O]]
    expect(round.instance_eval { check_combinations }).to eq('draw')
  end
end
