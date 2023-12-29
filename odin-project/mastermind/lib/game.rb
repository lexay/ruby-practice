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
  end
end
