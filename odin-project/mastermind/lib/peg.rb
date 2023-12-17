module Mastermind
  class Peg
    @count = 66

    class << self
      attr_accessor :count

      def create_each(num, colors = [])
        return if count.zero?

        pegs = []
        colors.each do |c|
          pegs.concat(Array.new(num) { Peg.new(c) })
        end
        pegs
      end
    end

    attr_reader :color

    def initialize(color)
      @color = color
      self.class.count -= 1
    end

    def ==(other)
      color == other.color
    end

    def hash
      color.hash
    end

    alias eql? ==
  end

  class KeyPeg < Peg
    @count = 20
    def self.create_each(num)
      super(num, %w[red white])
    end
  end

  class CodePeg < Peg
    @count = 60
    def self.create_each(num)
      super(num, %w[red blue green white black yellow])
    end
  end
end
