module TicTacToe
  class Player
    @count = 0
    @signs = %w[X O].shuffle

    class << self
      attr_accessor :count
      attr_reader :signs
    end

    attr_reader :name, :sign

    def name=(new_name)
      @name = new_name.capitalize unless new_name.empty?
    end

    def sign=(new_sign)
      signs = Player.signs
      new_sign.upcase!
      @sign = signs.include?(new_sign) ? signs.delete(new_sign) : signs.pop
    end

    def initialize
      Player.count += 1
      @name = Player.count
    end

    def make_move(table, player_index)
      current_index = 0
      player_index = player_index.to_i
      return unless player_index.between?(1, table.flatten.size)

      table.each_with_index do |row, ri|
        row.each_with_index do |_column, ci|
          current_index += 1
          return [ri, ci] if current_index == player_index
        end
      end
    end

    def to_s
      "Player: #{@name}, you sign is: '#{@sign}'"
    end
  end
end
