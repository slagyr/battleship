module WhiteHorseman
  class CellStatus
  
    attr_accessor :ship
    
    def initialize(was_hit=nil)
      @ship = :none
      
      case was_hit
      when nil
        @status = :none
      when true
        hit
      when false
        miss
      end
    end
    
    def hit
      @status = :hit
    end
    
    def miss
      @status = :miss
    end
    
    def hit?
      @status == :hit
    end
  
    def miss?
      @status == :miss
    end
    
    def empty?
      @status == :none
    end
    
    def has_ship?
      return @ship != :none
    end
    
  
  end
end