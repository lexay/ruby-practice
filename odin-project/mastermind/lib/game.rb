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

      begin
        secret = generate_secret
        cm.secret = secret
      rescue BadSecretError => e
        puts e.message
        retry
      end

      1.upto(10) do |round|
      end
    end

    def generate_secret
      pegs = CodePeg.create_each(1)
      secret = []
      4.times { secret.push(pegs.sample) }
      secret
    end
  end
end
