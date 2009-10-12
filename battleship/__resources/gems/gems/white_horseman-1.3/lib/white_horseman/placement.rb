require 'white_horseman/coordinates'

module WhiteHorseman
  class Placement
    attr_accessor :orientation, :size, :coord

    def initialize(options)
      @coord = Coordinates.new
      options.each do |option, value| 
        self.send("#{option}=".to_sym, value)
      end
    end
    
    def self.each(size, &block)
      Coordinates.each do |coordinate|
        [:horizontal, :vertical].each do |orientation|
          placement = Placement.new(:coord => coordinate, :orientation => orientation, :size => size)
          if placement.valid?
            yield(placement)
          end
        end
      end
    end
    
    def coord=(coord)
      @coord = Coordinates.new(:string => coord.to_s)
    end
    
    def row=(row)
      @coord.row = row
    end
    
    def column=(column)
      @coord.column = column
    end
    
    def row
      @coord.row
    end
    
    def column
      @coord.column
    end    
    
    def to_s
      "#{row}#{column} #{orientation}"
    end
    
    def valid?
      return false unless [:horizontal, :vertical].include?(@orientation)
      return false if end_row > "J" && @orientation == :vertical
      return false if end_column > 10 && @orientation == :horizontal
      return true
    end
    
    def end_row
      return "%c" % (@coord.row[0] + @size - 1) 
    end
    
    def end_column
      return @coord.column + @size - 1
    end
        
    def overlap?(other)
      return !(self.cells & other.cells).empty?
    end

    def cells
      cells = []
      for_each_cell {|cell| cells << cell.to_s}
      return cells
    end
    
    def include?(coord)
      return cells.include?(coord.to_s)
    end
    
    private #########################################################
    def for_each_cell(&block)
      coord_copy = Coordinates.new(:string => @coord.to_s)
      if @orientation == :horizontal
        yield(coord_copy)
        (size-1).times do
          coord_copy.inc_column
          yield(coord_copy)
        end
      elsif @orientation == :vertical
        yield(coord_copy)
        (size-1).times do
          coord_copy.inc_row
          yield(coord_copy)
        end
      end
    end
        
  end
end
