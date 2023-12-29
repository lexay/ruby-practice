module Mastermind
  class Game
    @count = 0

    class << Game
      attr_accessor :count
    end

    def initialize
      Game.count += 1
    end
  end
end
