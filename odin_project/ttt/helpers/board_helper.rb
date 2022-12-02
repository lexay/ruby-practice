module TicTacToe
  module Helper
    def to_s
      table = self.map { |row| row.join('   |   ') }.join("\n\n")
      "\n" << table << "\n"
    end
  end
end
