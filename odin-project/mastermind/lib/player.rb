module Mastermind
  class Player
    @count = 0

    class << self
      attr_accessor :count
    end

    attr_reader :name, :secret
    attr_accessor :points

    def name=(new_name)
      @name = new_name.capitalize unless new_name.empty?
    end

    def initialize
      Player.count += 1
      @name = Player.count
      @points = 0
    end

    private

    def secret=(new_secret)
      raise BadSecretError if new_secret.uniq.size == 1

      @secret = new_secret
    end
  end

  class HumanPlayer < Player
    include Console

    def generate_secret
      combination = %w[. . . .]
      colors = CodePeg.create_each(1)
      combination.map! do |_e|
        select_from_menu(colors)
      end
      self.secret = combination
    rescue BadSecretError => e
      puts e.message
      retry
    end
  end

  class CpuPlayer < Player
    def generate_secret
      pegs = CodePeg.create_each(1)
      combination = []
      4.times { combination.push(pegs.sample) }
      self.secret = combination
    rescue BadSecretError => e
      puts e.message
      retry
    end

    def give_clue(combination); end
  end
end
