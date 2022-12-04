module TicTacToe
  module BoardHelper
    def self.extended(obj)
      [obj.positions, obj.table].each { |o| o.extend Grid }
    end

    module Grid
      def to_s
        table = self.map { |row| row.join('   |   ') }.join("\n\n")
        "\n" << table << "\n"
      end
    end
  end
end
