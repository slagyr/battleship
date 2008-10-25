module Battleship

  class Game

    attr_reader :player1, :player2

    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
    end

    def position_ships(player)
      player.carrier_position
      player.battleship_position
      player.destroyer_position
      player.submarine_position
      player.patrolship_position
    end

  end

end