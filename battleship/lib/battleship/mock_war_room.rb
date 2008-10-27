module Battleship

  class MockShipStatus

    attr_reader :damage

    def damaged(damage)
      @damage = damage
    end

  end

  class MockSectors

    attr_reader :placements, :misses, :hits

    def initialize
      @placements = []
      @misses = []
      @hits = []
    end

    def place_ship(type, orientation, x, y)
      @placements << {:type => type, :orientation => orientation, :x => x, :y => y}
    end

    def miss(x, y)
      @misses << [x, y]
    end

    def hit(x, y)
      @hits << [x, y]
    end

    def reset
    end
  end

  class MockWarRoom

    attr_reader :commander, :result

    def initialize
      @statuses = {}
      @statuses[:carrier] = MockShipStatus.new
      @statuses[:battleship] = MockShipStatus.new
      @statuses[:destroyer] = MockShipStatus.new
      @statuses[:submarine] = MockShipStatus.new
      @statuses[:patrolship] = MockShipStatus.new

      @sectors = MockSectors.new
    end

    def commander=(name)
      @commander = name
    end

    def ship_statuses
      return @statuses
    end

    def sectors
      return @sectors
    end

    def victory!
      @result = :victory
    end

    def defeat!
      @result = :defeat
    end

    def disqualified!(reason)
      @result = "disqualified:#{reason}"
    end

  end

end