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
  it 'instance count if no name is chosen' do
    expect(p1.name).to eq(1)
    expect(p2.name).to eq(2)
  end

  it 'desired name' do
    p1.name = 'John'
    expect(p1.name).to eq('John')
  end
end

RSpec.describe 'Validates position entered by Player' do
  board.set(0, 0, 'X')

  it "valid if Player's input is between 1-9" do
    position = p1.make_move(board.table, 2)
    expect(round.instance_eval { validate(position) }).to eq(nil)
  end

  it "NOT valid if Player's input is out of 1-9 range" do
    position = p1.make_move(board.table, 100)
    expect(round.instance_eval { validate(position) }).to eq('Invalid input!')
  end

  it "NOT valid if Player's input is unexpected" do
    position = p1.make_move(board.table, 'one')
    expect(round.instance_eval { validate(position) }).to eq('Invalid input!')
  end

  it 'NOT valid if position is already taken' do
    position = p1.make_move(board.table, 1)
    expect(round.instance_eval { validate(position) }).to eq('Position is occupied! Choose another one!')
  end
end

RSpec.describe 'Player wins' do
  it '1st row is crossed' do
    board.table.replace [%w[X X X], %w[. . .], %w[. . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it '2nd row is crossed' do
    board.table.replace [%w[. . .], %w[X X X], %w[. . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it '3rd row is crossed' do
    board.table.replace [%w[. . .], %w[. . .], %w[X X X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it '1st column is crossed' do
    board.table.replace [%w[X . .], %w[X . .], %w[X . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it '2nd column is crossed' do
    board.table.replace [%w[. X .], %w[. X .], %w[. X .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it '3rd column is crossed' do
    board.table.replace [%w[. . X], %w[. . X], %w[. . X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'left diagonal is crossed' do
    board.table.replace [%w[X . .], %w[. X .], %w[. . X]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'right diagonal is crossed' do
    board.table.replace [%w[. . X], %w[. X .], %w[X . .]]
    expect(round.instance_eval { check_combinations }).to eq('win')
  end
end

RSpec.describe 'Players are drawn' do
  it 'no free positions left' do
    board.table.replace [%w[X O X], %w[O X O], %w[O X O]]
    expect(round.instance_eval { check_combinations }).to eq('draw')
  end
end
