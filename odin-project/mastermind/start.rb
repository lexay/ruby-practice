Dir['lib/*'].each { |f| require_relative f }
Mastermind::Game.new
