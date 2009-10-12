module WhiteHorseman
  class Ship
    attr_accessor :symbol
    def initialize(symbol)
      @symbol = symbol.to_sym
    end
    
    def size
      case @symbol
      when :battleship
        return 4
      when :carrier
        return 5
      when :patrolship
        return 2
      when :submarine
        return 3
      when :destroyer
        return 3
      else
        raise "bad ship type #{@symbol}"
      end
    end
    
    def ==(other)
      self.symbol == other.symbol
    end
    
    class << self
      def each(&block)
        [:carrier, :battleship, :destroyer, :submarine, :patrolship].each do |symbol|
          yield(Ship.new(symbol))
        end
      end
      
      def all
        ships = []
        self.each{|ship| ships << ship}
        return ships
      end
    end

  end

end