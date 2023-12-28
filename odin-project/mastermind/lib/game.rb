module Mastermind
  class Game
    include Console

    @count = 0

    class << Game
      attr_accessor :count
    end

    def initialize
      Game.count += 1
      run
    end

    private

    def run
      players = create_players
      cm, cb = assign_roles(players)
      cm.generate_secret

      loop do
        1.upto(10) do |round|
        end
      end
    end

    def create_players
      players = ['1 Player', '2 Players']
      players_count = select_from_menu(players)

      if players_count == '2 Players'
        [HumanPlayer.new, HumanPlayer.new]
      else
        [HumanPlayer.new, CpuPlayer.new]
      end
    end

    def assign_roles(players)
      roles = %w[CM CB]
      role = select_from_menu(roles)
      role.downcase == 'cm' ? players : players.reverse
    end
  end
end
