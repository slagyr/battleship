require 'matrix'
require 'white_horseman/coordinates'

module WhiteHorseman
  class Battlefield
    attr_reader :shots
    def initialize(grid = [
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0],
        ])
        @grid = grid
        @shots = 0
    end

    class << self
      def average(battlefields)
        seed = Battlefield.new
        seed.set_all(0.0)
        sum = battlefields.inject(Matrix.rows(seed.grid)) do |accumulator, battlefield|
          accumulator + Matrix.rows(battlefield.grid)
        end
        average = sum / battlefields.size
        return Battlefield.new(average.to_a)
      end
    end
    
    def record_target(coordinates)
      @shots +=1
      self[coordinates] = 100 - @shots
    end
    
    def [](coordinates)
      coord = coordinates.to_coord
      return @grid[coord.row_index][coord.column_index]
    end

    def []=(coordinates, value)
      coord = coordinates.to_coord
      
      @grid[coord.row_index][coord.column_index] = value
    end
    
    def grid
      return @grid
    end
    
    def set_all(value)
      10.times do |row|
        10.times do |column|
          @grid[row][column] = value
        end
      end
    end
    
  end
end
