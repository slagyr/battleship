require 'battleship/battleship_exceptions'

module Battleship

  class Grid

    CoordinatesRegex = /([A-J])(10|[1-9])/
    PlacementRegex = /([A-J]([1-9]|10)) (HORIZONTAL|VERTICAL)/

    def initialize
      clear
    end

    def place(ship, placement)
      match = PlacementRegex.match(placement.upcase)
      raise InvalidPlacementFormatException.new(placement) if match.nil?
      coordinates = match[1]
      orientation = match[3]

      index = to_index(coordinates)
      begin
        self[index] = ship
        (ship.length - 1).times do
          index = orientation == "HORIZONTAL" ? right(index) : down(index)
          self[index] = ship
        end
      rescue InvalidSectorException
        raise InvalidPlacementException.new("#{placement}: The #{ship.name} would fall off the edge")
      rescue SectorOccupiedException => soe
        raise InvalidPlacementException.new("#{placement}: The #{ship.name} would overlap the #{soe.ship.name}")
      end
    end

    def [](coordinates)
      return @sectors[to_index(coordinates)]
    end

    def clear
      @sectors = Array.new(100)
    end

    private ###############################################

    def []=(index, ship)
      raise SectorOccupiedException.new(@sectors[index]) if @sectors[index]
      @sectors[index] = ship
    end

    def to_index(coordinates)
      match = CoordinatesRegex.match(coordinates)
      raise InvalidSectorException.new(coordinates) if match.nil?
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
      raise InvalidSectorException.new("Sector index #{index} is on the right edge") if index % 10 == 9
      return index + 1
    end

    def down(index)
      raise InvalidSectorException.new("Sector index #{index} is on the bottom edge") if index > 89
      return index + 10
    end

  end

end