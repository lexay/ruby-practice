### Entities
Game, Game::Round, Player < Codemaker, Player < Codebreaker, SecretCode, Peg < KeyPeg, Peg < CodePeg,
Point, Message.

Game:
Has 10 Rounds.
Can be won or lost.
Can reveal SecretCode.
Can award Points.
Can show Message.
Can assign Codemaker and Codebreaker.

Player:
Has Points.

Codemaker:
Has SecretCode.
Has KeyPegs.
Can set SecretCode with CodePegs.
Can be given upto 4 KeyPegs per Game::Round in no particular order.
Can be awarded with 1 Point per 1 Row of CodePegs that Codebreaker sets unless
the Row is equal to SecretCode.
Can be awarded with 1 extra Point if after 10 Rows, the last Row is not
SecretCode.

SecretCode:
Has 4 CodePegs of one or more color.
Changes with new Round.

KeyPeg:
Can be red (right color in the right position) of white (right color NOT in the
right position), or nil (NOT used in the Row).

Codebreaker:
Has 10 Rows of CodePegs?
Can place 4 in one Row per Game::Round.

CodePeg:
Can be one of red, blue, yellow or green.
