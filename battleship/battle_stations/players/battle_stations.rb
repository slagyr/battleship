require 'battleship/game'
require 'battleship/simple_player'

module BattleStations

  def play
    war_room1 = find("war_room1")
    war_room2 = find("war_room2")

    game = Battleship::Game.new(@player1, war_room1, @player2, war_room2)
    game.prepare

    Thread.new { game.play }
  end

  def player1=(player)
    @player1 = player
  end

  def player2=(player)
    @player2 = player
  end

end