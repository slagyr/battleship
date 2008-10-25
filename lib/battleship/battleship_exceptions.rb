module Battleship

  class BattleshipException < Exception
  end

  class InvalidSectorException < BattleshipException
  end

  class InvalidPlacementFormatException < BattleshipException
    def initialize(placement)
      super("Invalid placement format: #{placement}")
    end
  end

  class InvalidPlacementException < BattleshipException
  end

  class SectorOccupiedException < BattleshipException

    attr_reader :ship

    def initialize(ship)
      @ship = ship  
    end

  end
end