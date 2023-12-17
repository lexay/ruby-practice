module Mastermind
  class Game
    @count = 0

    class << Game
      attr_accessor :round
    end

    attr_reader :code_pegs, :key_pegs

    def initialize
      code_pegs = CodePeg.create(10)
      key_pegs = KeyPeg.create(10)

      Game.count += 1

      cm = CodeMaker.new
      cb = CodeBreaker.new

      1.upto(10) do |round|
      end
    end
  end
end
