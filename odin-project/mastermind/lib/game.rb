module Mastermind
  class Game
    @count = 0

    class << Game
      attr_accessor :count
    end

    def initialize
      Game.count += 1
      run
    end

    def run
      players = create_players
      cm, cb = assign_roles(players)
    end

    def create_players
      players_menu = <<~MESSAGE
        1. 1 Player
        2. 2 Players
      MESSAGE
      puts players_menu
      print 'Choose number of players: '
      players_count = gets.to_i
      puts

      if players_count == 2
        [HumanPlayer.new, HumanPlayer.new]
      else
        [HumanPlayer.new, CpuPlayer.new]
      end
    end

    def assign_roles(players)
      roles_menu = <<~MESSAGE
        1. Code Maker
        2. Code Breaker
      MESSAGE
      puts roles_menu
      print 'Choose your role: '
      role = gets.to_i
      puts

      role == 1 ? players : players.reverse
    end
  end
end
