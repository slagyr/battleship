module Battleship

  class MockShipStatus

    attr_reader :damage

    def damaged(damage)
      @damage = damage
    end

    def blink
      @blinking = true
    end

    def stop_blinking
      @blinking = false
    end

  end

  class MockSector

    attr_reader :parent, :index

    def initialize(parent, index)
      @parent = parent
      @index = index
    end

    ROWS = %w{ A B C D E F G H I J }

    def coordinates
      row = ROWS[@index / 10]
      col = @index % 10 + 1
      return "#{row}#{col}"
    end

    def slope_to(sector)
      other_index = sector.index
      dx = (other_index % 10) - (@index % 10)
      dy = (@index / 10) - (other_index / 10)
      return (dy < 0 ? -100 : 100 ) if dx == 0
      return dy.to_f / dx.to_f
    end

    def right
      return nil if (@index % 10 == 9)
      return parent.children[@index + 1]
    end

    def down
      return nil if (@index > 89)
      return parent.children[@index + 10]
    end

    def highlight
      @highlighted = true
    end

    def unhighlight
      @highlighted = false
    end

  end

  class MockSectors

    attr_reader :placements, :misses, :hits, :children
    attr_accessor :statemachine

    def initialize
      @children = Array.new(100) { |i| MockSector.new(self, i) }
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

    def place_ship(name, orientation, col, row)
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

    def reset
    end

  end

end