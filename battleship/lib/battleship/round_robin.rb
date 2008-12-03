module Battleship

  class RoundRobin

    attr_reader :players
    attr_reader :rounds

    def initialize(players)
      @players = players
      generate_rounds
      randomize_players
      randamize_rounds
    end

    private ###############################################

    def generate_rounds
      @rounds = []
      @players.length.times do |i|
        (@players.length - i).times do |j|
          j = j + i
          if i != j
            @rounds << [@players[i], @players[j]]
          end
        end
      end
    end

    def randomize_players
      @rounds.length.times do |i|
        @rounds[i].reverse! if rand(2) == 1
      end
    end

    def randamize_rounds
      new_rounds = []
      while @rounds.length > 0
        new_rounds << @rounds.delete_at(rand(@rounds.length))  
      end

      @rounds = new_rounds
    end

  end
end