require 'battleship/mock_war_room'

module Battleship
  
  class MockBattleStations
    attr_reader :war_room1, :war_room2
    attr_accessor :was_reset, :stats

    def initialize
      @war_room1 = MockWarRoom.new
      @war_room2 = MockWarRoom.new
    end

    def exception(e)
      puts e
      puts e.backtrace
    end

    def reset
      @was_reset = true
    end

    def update_stats(stats)
      @stats = stats
      puts stats
    end

    def match_winner(name)
      puts "Match Winner: #{name}"
    end
  end

end