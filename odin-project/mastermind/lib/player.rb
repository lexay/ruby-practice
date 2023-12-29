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
    def generate_secret
      combination = []
      4.times do |i|
        colors = <<~MESSAGE
          1. Red
          2. Blue
          3. Green
          4. Black
          5. White
          6. Yellow
        MESSAGE
        puts colors
        print "Choose #{i + 1} color (1-6): "
        index = gets.to_i
        combination.push CodePeg.new(%w[red blue green black white yellow].at(index))
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
