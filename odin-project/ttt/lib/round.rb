module TicTacToe
  class Game
    class Round
      attr_reader :board

      def initialize(board, player1, player2)
        @board = board
        @player1 = player1
        @player2 = player2
      end

      def run
        rotate_players
      end

      private

      def players
        [@player1, @player2]
      end

      def rotate_players
        loop do
          players.each do |player|
            Game.show("Player: #{player.name}, your turn!")
            prompt(player)
            Game.show(board.table)
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
        position = Game.ask(player, 'Enter position number(1-9): ', :make_move, board.table)
        validate(position)
        board.set(*position, player.sign)
      rescue InputError, PositionNotEmptyError => e
        Game.show(e.message)
        retry
      end

      def validate(position)
        raise InputError if position.nil?
        raise PositionNotEmptyError unless board.empty?(*position)
      end

      def check_combinations
        table = board.table
        horizontal = table
        vertical = table.transpose
        diagonals = [table, table.reverse].map { |t| t.map.with_index { |row, i| row[i] } }
        combinations = [horizontal, vertical, diagonals].flatten(1)
        return 'win' if combinations.any? { |c| c.all?('X') || c.all?('O') }
        return 'draw' if combinations.all? { |c| c.none?('.') }
      end
    end
  end
end
