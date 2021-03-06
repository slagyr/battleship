module Battleship

  class Ship

    attr_reader :length, :name, :life

    def initialize(length, name)
      @length = length
      @life = length
      @name = name
    end

    def hit!
      @life -= 1
    end

    def sunk?
      return @life == 0
    end

    def damage
      return (((@length - @life).to_f / @length.to_f) * 100.0).to_i
    end

  end

  class Carrier < Ship

    def initialize()
      super(5, "carrier")
    end

  end

  class Battleship < Ship

    def initialize()
      super(4, "battleship")
    end

  end

  class Destroyer < Ship

    def initialize()
      super(3, "destroyer")
    end

  end

  class Submarine < Ship

    def initialize()
      super(3, "submarine")
    end

  end

  class Patrolship < Ship

    def initialize()
      super(2, "patrolship")
    end

  end

end