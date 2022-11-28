require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)
Bundler.require(:default, :development)

module TicTacToe
  class Game
    def self.draw(message, chomp: false)
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
      Game.draw(question, chomp: true)
      player.send(*args, gets.strip)
    end

    def initialize(board, player1, player2)
      @board = board
      @player1 = player1
      @player2 = player2
    end

    def run
      Game.draw(Messages.head)
      Game.draw('Choose your destiny!')
      setup_players
      show_grid
      loop do
        take_turns
      end
    end

    private

    def players
      [@player1, @player2]
    end

    def show_grid
      Game.draw('Default grid:')
      Game.draw(@board.positions)
    end

    def setup_players
      players.each do |player|
        Game.ask(player, 'Choose your name: ', :name=)
        Game.ask(player, "Player: #{player.name}, choose your letter: ", :letter=)
        Game.draw(player)
      end
    end

    def take_turns
      players.each do |player|
        Game.draw("Player: #{player.name}, your turn!")
        row, column = Game.ask(player, 'Enter position number(1-9): ', :make_move, @board.table)
        @board.set(row, column, player.letter)
        Game.draw(@board.table)
      end
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
  end

  class Player
    @count = 0
    @letters = %w[X O].shuffle

    class << self
      attr_accessor :count
      attr_reader :letters
    end

    attr_reader :name, :letter

    def name=(new_name)
      @name = new_name.capitalize unless new_name.empty?
    end

    def letter=(new_letter)
      letters = Player.letters
      new_letter.upcase!
      @letter = letters.include?(new_letter) ? letters.delete(new_letter) : letters.pop
    end

    def initialize
      Player.count += 1
      @name = Player.count
    end

    def make_move(table, player_index)
      current_index = 0
      player_index = player_index.to_i
      table.each_with_index do |row, ri|
        row.each_with_index do |_column, ci|
          current_index += 1
          return [ri, ci] if current_index == player_index
        end
      end
    end

    def to_s
      "Player: #{@name}, you are: '#{@letter}'"
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

# Notes:
#
# * Entities:
#   Game, Board, Player, Messages?
#
# * Game:
#   Includes Board, Player 1, Player 2.
#   Can ask Player for input.
#   Can draw table.
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
#   [?] Setup board interactivelly?
#   [?] Set inner class methods to be private?
