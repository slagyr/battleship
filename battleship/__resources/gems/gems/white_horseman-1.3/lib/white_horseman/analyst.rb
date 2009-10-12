require 'white_horseman/coordinates'
require 'white_horseman/scout'
require 'white_horseman/ship'
module WhiteHorseman
  class Analyst
    def initialize(hit_map, live_ships)
      @live_ships = live_ships
      @hit_map = hit_map
      @scout = Scout.new
    end
    
    def hit_probability(coordinate)
      probability = probability_from_neighbors(1, coordinate)
      probability += probability_from_neighbors(2, coordinate)
      
      possible_placements_here = 0
      @live_ships.each do |ship|
        possible_placements_here += @scout.possible_placements(ship.size, [coordinate], @hit_map)
      end
      probability += 0.17 * possible_placements_here / 34.0
     return probability
    end

    private
    
    def probability_for(coordinate, neighbor, ship)
      placements_including_coordinate = @scout.possible_placements(ship.size, [coordinate, neighbor], @hit_map)
      total_placements = @scout.possible_placements(ship.size, [neighbor], @hit_map)

      return (probability_is(ship) * placements_including_coordinate / total_placements) if total_placements != 0
      return 0.0
    end
    
    def hit?(coordinate)
      @hit_map[coordinate].hit?
    end
    
    def miss?(coordinate)
      @hit_map[coordinate].miss?
    end
    
    def probability_is(ship)
      if @live_ships.include?(ship)
        return 1.0 / @live_ships.size
      else
        return 0.0
      end
    end
    
    def probability_from_neighbors(degree, coordinate)
      probability = 0.0
      coordinate.to_coord.neighbors(degree).each do |neighbor|
        if hit?(neighbor)
          Ship.each do |ship|
            probability += probability_for(coordinate, neighbor, ship)
          end
        end
      end
      return probability    
    end
    
  end
end
