module Mastermind
  class Game
    @count = 0

    class << Game
      attr_accessor :count
    end

    attr_reader :console

    def initialize
      Game.count += 1
      @console = IO.new(0, 'w+')
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
      puts hint
      puts p1_menu
      players_count = choose_players

      if players_count == 2
        [HumanPlayer.new, HumanPlayer.new]
      else
        [HumanPlayer.new, CpuPlayer.new]
      end
    end

    def choose_players
      players_count = 1

      loop do
        c = read_char

        redo unless ["\e[A", "\e[B", "\r"].include?(c)

        console.clear_screen

        case c
        when "\e[A"
          puts hint
          puts p1_menu
          players_count -= 1 if players_count == 2
        when "\e[B"
          puts hint
          puts p2_menu
          players_count += 1 if players_count == 1
        when "\r"
          break
        end
      end
      players_count
    end

    def read_char
      console.echo = false
      console.raw!

      input = console.getc.chr
      if input == "\e"
        input << console.read_nonblock(3) rescue nil
        input << console.read_nonblock(2) rescue nil
      end
      input
    ensure
      console.echo = true
      console.cooked!
    end

    def assign_roles(players)
      print 'Choose your role (CM/CB): '
      role = gets.strip.downcase

      role == 'cm' ? players : players.reverse
    end

    def p1_menu
      <<~MESSAGE
        =============
        [ 1 Player ]
          2 Players
        =============
      MESSAGE
    end

    def p2_menu
      <<~MESSAGE
        =============
          1 Player
        [ 2 Players ]
        =============
      MESSAGE
    end

    def hint
      'Hint: use arrow keys!'
    end
  end
end
