require "white_horseman/coordinates"
require "white_horseman/placement"

module WhiteHorseman
  class Scout    
    def possible_placements(size, coordinates, hit_board)
      placements = []
      first = coordinates.first.to_coord
      placements += placements(size, first.clone, coordinates, :horizontal)
      placements += placements(size, first.clone, coordinates, :vertical)
      scrub(placements, hit_board)
      
      return placements.size
    end
    
    def salvage_placements(size, coordinate, hit_board)
      placements = []
      first = coordinate.to_coord
      placements += placements(size, first.clone, [coordinate], :horizontal)
      placements += placements(size, first.clone, [coordinate], :vertical)
      return select_all_hits(placements, hit_board)
    end
    

    private ################################################################################

    def placements(size, start, coordinates, orientation)
      return [] unless Coordinates.colinear?(coordinates, orientation)
      
      itr = Coordinates.new(:string => start.to_s)
      placements = []
      size.times do
        placement = Placement.new(:coord => itr, :orientation => orientation, :size => size)
        if placement.valid? && coordinates.all?{|cell| placement.include?(cell)}
          placements << placement
        end
        itr.inc_row -1 if orientation == :vertical rescue break
        itr.inc_column -1 if orientation == :horizontal rescue break
      end 
      return placements
    end

    def scrub(placements, hit_board)
      doomed = []
      placements.each do |placement|
        placement.cells.each do |cell|
          if (hit_board[cell].miss? || hit_board[cell].has_ship?)
            doomed << placement
          end
        end
      end
      doomed.each {|dead| placements.delete(dead) }
    end
    
    def select_all_hits(placements, hit_board)
      all_hits = []
      placements.each do |placement|
        if placement.cells.all?{|cell| hit_board[cell].hit?}
          all_hits << placement
        end
      end
      return all_hits
    end
    
  end
end
