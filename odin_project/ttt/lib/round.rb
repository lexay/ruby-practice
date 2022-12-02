module TicTacToe
  class Game
    class Round
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
  end
end
