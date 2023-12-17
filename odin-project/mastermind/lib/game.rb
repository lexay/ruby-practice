module Mastermind
  class Game
    @count = 0

    class << Game
      attr_accessor :count
    end

    attr_reader :code_pegs, :key_pegs

    def initialize
      code_pegs = CodePeg.create_each(10)
      key_pegs = KeyPeg.create_each(10)

      Game.count += 1

      cm = CodeMaker.new
      cb = CodeBreaker.new

      1.upto(10) do |round|
      end
    end
  end
end
