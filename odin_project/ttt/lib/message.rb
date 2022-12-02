module TicTacToe
  class Message
    def self.welcome
      <<~FRAME
        ########################
        |                      |
        |       Welcome!       |
        +                      +
        |  Lets play some TTT  |
        |                      |
        ########################
      FRAME
    end

    def self.bye
      <<~FRAME

        ########################
        |                      |
        |       Goodbye!       |
        +                      +
        |    See you later!    |
        |                      |
        ########################
      FRAME
    end
  end
end
