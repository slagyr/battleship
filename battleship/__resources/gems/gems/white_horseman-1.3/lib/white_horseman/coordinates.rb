class String
  def to_coord
    return WhiteHorseman::Coordinates.new(:string => self)
  end
end
  
module WhiteHorseman
  class Coordinates
    attr_reader :row, :column
    def initialize(options={:row => "A", :column => 1})
      options.each do |option, value|
        send("#{option}=".to_sym, value)
      end
    end
    
    def string=(coord_string)
      self.row = "%c" % coord_string.upcase[0]
      self.column = (coord_string[1..-1]).to_i
    end
    
    def column=(value)
      raise "Column out of range: #{value}" if value > 10 || value < 1
      @column = value
    end

    def inc_column(delta = 1)
      self.column = @column + delta
      return self
    end
    
    def row=(value)
      raise "Row out of range: #{value}" if value > "J" || value < "A"
      @row = value
    end
    
    def inc_row(delta=1)
      self.row = "%c" % (self.row[0] += delta)
      return self
    end
    
    def to_s
      "#{row}#{column}"
    end
    
    def row_index
      row[0] - 65
    end
    
    def column_index
      @column - 1
    end
    
    def to_coord
      return self
    end
    
    def ==(other)
      return self.column == other.to_coord.column && self.row == other.to_coord.row
    end
    
    def neighbors(distance=1)
      neighbors = []
      neighbors << Coordinates.new(:string => self.to_s).inc_row(distance) unless self.row_index > 9 - distance
      neighbors << Coordinates.new(:string => self.to_s).inc_row(-1*distance) unless self.row_index < distance
      neighbors << Coordinates.new(:string => self.to_s).inc_column(distance) unless self.column_index > 9 - distance
      neighbors << Coordinates.new(:string => self.to_s).inc_column(-1*distance) unless self.column_index < distance
      return neighbors
    end
    
    
    def self.colinear?(coordinates, orientation=nil)
      first = coordinates.first.to_coord      
      return colinear?(coordinates, :vertical) || colinear?(coordinates, :horizontal) if orientation. nil?
      return coordinates.all?{|coord| coord.to_coord.column == first.column} if orientation.to_sym == :vertical
      return coordinates.all?{|coord| coord.to_coord.row == first.row} if orientation.to_sym == :horizontal
    end
    
    def self.each(&block)
      ("A".."J").each do |row|
        (1..10).each do |column|
          yield(Coordinates.new(:row => row, :column => column))
        end
      end
    end
    
  end
end
