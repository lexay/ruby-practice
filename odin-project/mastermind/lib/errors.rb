module Mastermind
  class BadSecretError < StandardError
    def to_s
      'Unacceptable combination'
    end
  end
end
