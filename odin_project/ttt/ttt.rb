require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)
Bundler.require(:default, :development)

module TicTacToe
  class Game
    def self.show(message, chomp: false)
      message.to_s.each_line(chomp: chomp) do |line|
        console_width = IO.console.winsize.last
        offset = (console_width + line.length) / 2
        print line.rjust(offset)
      end
      return if chomp

      2.times { puts }
    end

    def self.ask(player, *args)
      question = args.shift
      Game.show(question, chomp: true)
      player.send(*args, gets.strip)
    end

    def initialize(board, player1, player2)
      @board = board
      @player1 = player1
      @player2 = player2
    end

    def run
      Game.show(Messages.head)
      Game.show('Choose your destiny!')
      ready_players
      show_grid
      rotate_players
    end

    private

    def players
      [@player1, @player2]
    end

    def show_grid
      Game.show('Default grid:')
      Game.show(@board.positions)
    end

    def ready_players
      players.each do |player|
        Game.ask(player, 'Choose your name: ', :name=)
        if player == @player1
          Game.ask(player, "Player: #{player.name}, choose your sign: ", :sign=)
        else
          player.sign = Player.signs.last
        end
        Game.show(player)
      end
    end

    def rotate_players
      loop do
        players.each do |player|
          Game.show("Player: #{player.name}, your turn!")
          prompt(player)
          Game.show(@board.table)
          case check_combinations
          when 'win'
            return Game.show("Player: #{player.name} wins!")
          when 'draw'
            return Game.show('Draw!')
          end
        end
      end
    end

    def prompt(player)
      loop do
        position = Game.ask(player, 'Enter position number(1-9): ', :make_move, @board.table)
        if position.nil?
          Game.show 'Invalid input!'; redo
        elsif !@board.empty?(*position)
          Game.show("Player: #{player.name}, position is occupied! Choose another one!"); redo
        else
          @board.set(*position, player.sign); break
        end
      end
    end

    def check_combinations
      table = @board.table
      horizontal = table
      vertical = table.transpose
      diagonal_left = [table.map.with_index { |row, i| row[i] }]
      diagonal_right = [table.reverse.map.with_index { |row, i| row[i] }]
      combinations = [horizontal, vertical, diagonal_left, diagonal_right].flatten(1)
      return 'win' if combinations.any? { |c| c.all?('X') || c.all?('O') }
      return 'draw' if combinations.all? { |c| c.none?('.') }
    end
  end

  class Board
    attr_reader :table, :positions

    def initialize(rows = 3, columns = 3)
      @table = Array.new(rows) { Array.new(columns) {  '.' } }
      @positions = Array.new(rows * columns) { |i| i + 1 }.each_slice(columns)
      @table.extend Helper
      @positions.extend Helper
    end

    def set(row, column, value)
      @table[row][column] = value
    end

    def empty?(row, column)
      @table[row][column] == '.'
    end
  end

  class Player
    @count = 0
    @signs = %w[X O].shuffle

    class << self
      attr_accessor :count
      attr_reader :signs
    end

    attr_reader :name, :sign

    def name=(new_name)
      @name = new_name.capitalize unless new_name.empty?
    end

    def sign=(new_sign)
      signs = Player.signs
      new_sign.upcase!
      @sign = signs.include?(new_sign) ? signs.delete(new_sign) : signs.pop
    end

    def initialize
      Player.count += 1
      @name = Player.count
    end

    def make_move(table, player_index)
      current_index = 0
      player_index = player_index.to_i
      return unless player_index.between?(1, table.flatten.size)

      table.each_with_index do |row, ri|
        row.each_with_index do |_column, ci|
          current_index += 1
          return [ri, ci] if current_index == player_index
        end
      end
    end

    def to_s
      "Player: #{@name}, you sign is: '#{@sign}'"
    end
  end

  class Messages
    def self.head
      <<~FRAME
        ########################
        |                      |
        |        Welcome!      |
        +                      +
        |  Lets play some TTT  |
        |                      |
        ########################
      FRAME
    end
  end

  module Helper
    def to_s
      "\n" << self.map { |row| row.join('   |   ') }.join("\n\n")
    end
  end
end

board = TicTacToe::Board.new
p1 = TicTacToe::Player.new
p2 = TicTacToe::Player.new
game1 = TicTacToe::Game.new(board, p1, p2)
game1.run
# loop { TicTacToe::Game.new(board, p1, p2).run }
# Notes:
#
# * Entities:
#   Game, Board, Player, Messages?
#
# * Game:
#   Includes Board, Player 1, Player 2.
#   Can ask Player for input.
#   Can show table.
#
# * Board:
#   Can have adjustable size.
#   Can set columns with Player's input.

# * Player:
#   Can have name.
#   Can have 'X' or 'O'.
#   Can make moves?
#
# * TODO:
#   [X] Make possible to choose from range 1-9 instead of row and col nums.
#   [?] Board.set_column (Game.ask player, ...) or Player.make_move?
#   [?] Set inner class methods to be private?
#   [ ] Prompt for another game in loop?
#   [?] Setup board interactivelly?
#   [ ] Exit gracefully when interrupted.
