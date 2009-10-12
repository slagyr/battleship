require 'white_horseman/placement'
require 'white_horseman/coordinates'
module WhiteHorseman
  class FleetAdmiral
    attr_accessor :heat_map
    
    def calculate
      @min_placements = {}
      [["carrier", 5], ["battleship", 4], ["destroyer", 3], ["submarine", 3], ["patrolship", 2]].each do |ship|
        placement = place_ship(ship[1])
        raise "Couldn't place #{ship[0]}!" if placement.nil?
        @min_placements[ship[0]] = placement
      end      
    end
    
    def carrier
      check_for_calculate
      return @min_placements["carrier"].to_s
    end

    def battleship
      check_for_calculate
      return @min_placements["battleship"].to_s
    end

    def destroyer
      check_for_calculate
      return @min_placements["destroyer"].to_s
    end

    def submarine
      check_for_calculate
      return @min_placements["submarine"].to_s
    end

    def patrolship
      check_for_calculate
      return @min_placements["patrolship"].to_s
    end
    
    private #####################################################################################################

    def place_ship(size)
      min_threat = 999999999999
      min_placements = []
      Placement.each(size) do |placement|
        unless overlaps_another_ship?(placement)
          threat = threat(placement)
        
          if threat < min_threat
            min_threat = threat
            min_placements = [placement]
          elsif threat == min_threat
            min_placements << placement
          end
        end            
      end

      return min_placements[rand(min_placements.size)]
    end

    def check_for_calculate
      raise "Call calculate first" if @min_placements.nil?
    end
    
    def overlaps_another_ship?(placement)
      @min_placements.each do |ship, existing_placement|
        return true if placement.overlap?(existing_placement)
      end
      return false
    end
    
    def threat(placement)
      return placement.cells.inject(0) {|threat, cell| threat + @heat_map[cell]}
    end

  end
  
end
