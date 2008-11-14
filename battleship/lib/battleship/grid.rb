require 'battleship/battleship_exceptions'

module Battleship

  class Sector

    attr_accessor :ship, :attacked

  end

  class Grid

    CoordinatesRegex = /([A-J])(10|[1-9])/
    PlacementRegex = /([A-J]([1-9]|10)) (HORIZONTAL|VERTICAL)/

    attr_reader :view

    def initialize(view)
      @view = view
      clear
    end

    def place(ship, placement)
      match = PlacementRegex.match(placement.upcase)
      raise InvalidPlacementFormatException.new(placement) if match.nil?
      coordinates = match[1]
      orientation = match[3]
      start_index = index = to_index(coordinates)

      begin
        sectors_for(coordinates, orientation, ship.length).each do |sector|
          raise SectorOccupiedException.new(sector.ship) if sector.ship
          sector.ship = ship
        end
      rescue InvalidSectorException
        raise InvalidPlacementException.new("#{placement}: The #{ship.name} would fall off the edge")
      rescue SectorOccupiedException => soe
        raise InvalidPlacementException.new("#{placement}: The #{ship.name} would overlap the #{soe.ship.name}")
      end

      @view.place_ship(ship.name, orientation.downcase.to_sym, start_index % 10, start_index / 10)
    end

    def sectors_for(anchor, orientation, length)
      orientation = orientation.to_s.downcase.to_sym
      sectors = []

      start_index = index = to_index(anchor)
      sectors << @sectors[start_index]
      (length - 1).times do
        index = orientation == :horizontal ? right(index) : down(index)
        sectors << @sectors[index]
      end

      return sectors
    end

    def valid_placement?(anchor, orientation, length)
      begin
        return sectors_for(anchor, orientation, length).all? { |sector| sector.ship.nil? }
      rescue BattleshipException => e
        return false
      end
    end

    def attack(coordinates)
      index = to_index(coordinates)
      sector = @sectors[index]
      raise SectorAlreadyAttackedException.new(coordinates) if sector.attacked
      sector.attacked = true
      sector.ship.nil? ? @view.miss(index % 10, index / 10) : @view.hit(index % 10, index / 10)
      return sector.ship
    end

    def [](coordinates)
      return @sectors[to_index(coordinates)]
    end

    def clear
      @sectors = Array.new(100) { Sector.new }
      @view.reset
    end

    private ###############################################

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