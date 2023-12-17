module Mastermind
  class Player
    @count = 0

    class << self
      attr_accessor :count
    end

    attr_reader :name
    attr_accessor :points

    def name=(new_name)
      @name = new_name.capitalize unless new_name.empty?
    end

    def initialize
      Player.count += 1
      @name = Player.count
      @points = 0
    end
  end

  class CodeMaker < Player
    attr_reader :secret

    def secret=(new_secret)
      raise StandardError, 'Unacceptable combination!' if new_secret.uniq.size = 1

      @secret = new_secret
    end
  end

  class CodeBreaker < Player
  end
end

# Generate @secret in-place if no input from CodeMaker.
