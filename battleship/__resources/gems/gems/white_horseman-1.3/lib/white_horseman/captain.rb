require "white_horseman/battlefield"
require "white_horseman/placement"
require "white_horseman/coordinates"
require "white_horseman/analyst"
require "white_horseman/cell_status"

module WhiteHorseman
  
  class Captain
    attr_accessor :hit_map
    attr_accessor :live_ships

    def initialize
      @hit_map = Battlefield.new
      @hit_map.set_all(CellStatus.new)
      @live_ships = Ship.all
    end
    
    def target_result(coordinates, was_hit, ship_sunk)
      @hit_map[coordinates] = CellStatus.new(was_hit)
      unless ship_sunk.nil?
        ship = Ship.new(ship_sunk)
        live_ships.delete(ship)
        scout = Scout.new
        salvage = scout.salvage_placements(ship.size, coordinates, @hit_map)
        intersection = salvage.first.cells
        salvage.each do |placement|
          intersection &= placement.cells
        end
        
        intersection.each do |cell|
          @hit_map[cell].ship = ship_sunk
        end
        
        @hit_map[coordinates].ship = ship_sunk
      end
    end    
            
    def next_target
      analyst = Analyst.new(@hit_map, @live_ships)
      max_probability = 0.0
      top_shots = []
      Coordinates.each do |coordinate|
        if @hit_map[coordinate].empty?
          probability = analyst.hit_probability(coordinate)
          if probability > max_probability
            max_probability = probability
            top_shots = [coordinate]
          elsif probability == max_probability
            top_shots << coordinate
          end
        end
      end
      return top_shots[rand(top_shots.size)].to_s
    end
    
  end
end
