module TicTacToe
  class Board
    attr_reader :table, :positions

    def initialize(rows = 3, columns = 3)
      @table = Array.new(rows) { Array.new(columns) {  '.' } }
      @positions = Array.new(rows * columns) { |i| i + 1 }.each_slice(columns)
      @table.extend Helper
      @positions.extend Helper
    end

    def set(row, column, value)
      @table[row][column] = value
    end

    def empty?(row, column)
      @table[row][column] == '.'
    end
  end
end
