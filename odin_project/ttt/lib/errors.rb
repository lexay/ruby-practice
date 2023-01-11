module TicTacToe
  class InputError < StandardError
    def to_s
      'Invalid input!'
    end
  end

  class PositionNotEmptyError < StandardError
    def to_s
      'Position is not empty! Choose another one!'
    end
  end
end
