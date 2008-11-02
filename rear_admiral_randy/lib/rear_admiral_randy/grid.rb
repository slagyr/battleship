module RearAdmiralRandy
  class Sector

    attr_accessor :ship, :attacked

  end

  class Grid

    CoordinatesRegex = /([A-J])(10|[1-9])/
    PlacementRegex = /([A-J]([1-9]|10)) (HORIZONTAL|VERTICAL)/


    def initialize
      clear
    end

    def place(ship, placement)
      match = PlacementRegex.match(placement.upcase)
      raise Exception.new(placement) if match.nil?
      coordinates = match[1]
      orientation = match[3]

      start_index = index = to_index(coordinates)
      self[index] = ship
      (ship.length - 1).times do
        index = orientation == "HORIZONTAL" ? right(index) : down(index)
        self[index] = ship
      end

    end

    def attack(coordinates)
      index = to_index(coordinates)
      sector = @sectors[index]
      raise Exception.new(coordinates) if sector.attacked
      sector.attacked = true
      return sector.ship
    end

    def [](coordinates)
      return @sectors[to_index(coordinates)]
    end

    def clear
      @sectors = Array.new(100) { Sector.new }
    end

    private ###############################################

    def []=(index, ship)
      raise Exception.new(@sectors[index].ship) if @sectors[index].ship
      @sectors[index].ship = ship
    end

    def to_index(coordinates)
      match = CoordinatesRegex.match(coordinates)
      raise Exception.new(coordinates) if match.nil?
      row = match[1]
      col = match[2]

      row_index = row_to_index(row)
      col_index = col.to_i - 1
      return row_index * 10 + col_index
    end

    Rows = %w{ A B C D E F G H I J }
    def row_to_index(row)
      return Rows.index(row)
    end

    def right(index)
      raise Exception.new("Sector index #{index} is on the right edge") if index % 10 == 9
      return index + 1
    end

    def down(index)
      raise Exception.new("Sector index #{index} is on the bottom edge") if index > 89
      return index + 10
    end

  end
end
