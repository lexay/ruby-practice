require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)
Bundler.require(:default, :development)

module TicTacToe
  Signal.trap('INT') do
    Game.show(Message.bye)
    exit
  end
end

Dir['./lib/*.rb', './helpers/*'].each { |f| require_relative f }
TicTacToe::Game.start

# Notes:
#
# * Entities:
#   Game, Game::Round, Board, Player, Message.
#
# * Game:
#   Has Rounds.
#   Can ask Player for input.
#   Can show Message.
#
# * Round:
#   Has Board, Player1, Player1.

# * Board:
#   Can have adjustable grid.
#   Can set position grid with Player's input.

# * Player:
#   Can have name.
#   Can have 'X' or 'O' sign.
#   Can make move.
#
# * Message
#   Has messages.
#
# TODO:
#   [X] Make possible to choose from range 1-9 instead of row and col nums.
#   [X] Prompt for another round in loop.
#   [X] Setup board interactivelly.
#   [X] Exit gracefully when interrupted.

#   [?] Board.set_column (Game.ask player, ...) or Player.make_move?
#   [?] New folder for Game and Game::Round in 'lib' folder asto show they are
#   kinda in one nested namespace? or 'game_round.rb'?
#   [?] Implement client and server?
