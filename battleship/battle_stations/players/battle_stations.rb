require 'battleship/game'
require 'battleship/simple_player'

module BattleStations

  def play
puts "Battle Stations playing"    

    war_room1 = find("war_room1")
    war_room2 = find("war_room2")
    player1 = Battleship::SimplePlayer.new("Player1")
    player2 = Battleship::SimplePlayer.new("Player2")

    game = Battleship::Game.new(player1, war_room1, player2, war_room2)
    game.prepare

    Thread.new { game.play }
    
  end

end