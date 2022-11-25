require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)
Bundler.require(:default, :development)

module TicTacToe
  class Game
    C_WIDTH = IO.console.winsize.last

    def initialize(board, player1, player2)
      @board = board
      @player1 = player1
      @player2 = player2
    end

    def run
      Game.draw(Messages.head, chomp: true)
      Game.draw('Choose your destiny!')
      Game.ask(@player1, 'Choose your name: ', :name=)
      Game.ask(@player1, "Player: #{@player1.name}, choose your letter: ", :letter=)
      Game.ask(@player2, 'Choose your name: ', :name=)
      Game.ask(@player2, "Player: #{@player2.name}, choose your letter: ", :letter=)
      Game.draw(@player1.to_s)
      Game.draw(@player2.to_s)
      Game.draw(@board.table)
    end

    def self.draw(message, chomp: false)
      message.each_line(chomp: chomp) do |line|
        puts line.center(C_WIDTH)
      end
      puts
    end

    def self.ask(player, question, method)
      print question.rjust(C_WIDTH / 2 + question.length / 2)
      player.send(method, gets.strip)
      puts
    end
  end

  class Board
    def self.init(rows = 3, columns = 3)
      self.new(rows, columns)
    end

    def initialize(rows, columns)
      @table = Array.new(rows) { Array.new(columns) {  '.' } }
    end

    def table
      @table.map { |row| row.join('   |   ') }.join("\n")
    end

    def set_column(row, column, value)
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
end

board = TicTacToe::Board.init
board.set_column(0, 0, 'X')
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
#   Can set columns with input.

# * Player:
#   Can have name.
#   Can have 'X' or 'O'.
#   Can make moves?
