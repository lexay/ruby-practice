require_relative '../lib/round.rb'
require_relative '../lib/board.rb'
require_relative '../helpers/board_helper.rb'
require_relative '../lib/player.rb'
require 'spec_helper'

p1 = TicTacToe::Player.new
p2 = TicTacToe::Player.new

RSpec.describe 'Player wins' do
  3.times do |idx|
    it "returns win if #{idx + 1}st row is won" do
      board = TicTacToe::Board.new
      round = TicTacToe::Game::Round.new(board, p1, p2)
      board.table[idx] = %w[X X X]
      expect(round.instance_eval { check_combinations }).to eq('win')
    end
  end

  3.times do |idx|
    it "returns win if #{idx + 1}st column is won" do
      board = TicTacToe::Board.new
      round = TicTacToe::Game::Round.new(board, p1, p2)
      board.table.map { |row| row[idx] = 'X' }
      expect(round.instance_eval { check_combinations }).to eq('win')
    end
  end

  it 'returns win if left diagonal is won' do
    board = TicTacToe::Board.new
    round = TicTacToe::Game::Round.new(board, p1, p2)
    board.table.map.with_index { |row, idx| row[idx] = 'X' }
    expect(round.instance_eval { check_combinations }).to eq('win')
  end

  it 'returns win if right diagonal is won' do
    board = TicTacToe::Board.new
    round = TicTacToe::Game::Round.new(board, p1, p2)
    board.table.reverse.map.with_index { |row, idx| row[idx] = 'X' }
    expect(round.instance_eval { check_combinations }).to eq('win')
  end
end

RSpec.describe 'Players are drawn' do
  it 'returns draw if no free positions left' do
    board = TicTacToe::Board.new
    round = TicTacToe::Game::Round.new(board, p1, p2)
    board.table.replace [%w[X O X], %w[O X O], %w[O X O]]
    expect(round.instance_eval { check_combinations }).to eq('draw')
  end
end
