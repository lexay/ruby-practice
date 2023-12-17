module Mastermind
  class Board
    attr_reader :table

    def initialize
      @table = Array.new(10) { Array.new(4) { '.' } }
    end

    def get(row, column)
      @table[row][column]
    end

    def set(row, column, peg)
      @table[row][column] = peg
    end
  end
end
