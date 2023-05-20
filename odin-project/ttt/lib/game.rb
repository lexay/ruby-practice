module TicTacToe
  class Game
    def self.start
      new.run
    end

    def self.show(message, chomp: false)
      message.to_s.each_line(chomp: chomp) do |line|
        console_width = IO.console.winsize.last
        offset = (console_width + line.length) / 2.0
        print line.rjust(offset.round)
      end
      return if chomp

      puts "\n\n"
    end

    def self.ask(player, *args)
      question = args.shift
      Game.show(question, chomp: true)
      player.send(*args, gets.strip)
    end

    def run
      roll
    end

    private

    def roll
      Game.show(Message.welcome)
      Game.show('Choose your destiny!')
      p1 = Player.new
      p2 = Player.new
      players = [p1, p2]
      set(players)
      run_rounds(players)
    end

    def set(players)
      players.each do |player|
        Game.ask(player, 'Choose your name: ', :name=)
        if player == players.first
          Game.ask(player, "Player: #{player.name}, choose your sign X/O or random: ", :sign=)
        else
          player.sign = Player.signs.last
        end
        Game.show(player)
      end
    end

    def run_rounds(players)
      loop do
        board = Board.new
        Game.show('Positions:')
        Game.show(board.positions)
        Round.new(board, *players).run
        Game.show('Wanna play again?(Y/N): ', chomp: true)
        continue = gets.strip.downcase
        return Game.show(Message.bye) unless continue == 'y'

        players = players.shuffle
      end
    end
  end
end
