require 'battleship/grid'
require 'battleship/ship'

module Battleship

  class Game

    attr_reader :player1, :player2
    attr_reader :war_room1, :war_room2
    attr_reader :fleet1, :fleet2
    attr_reader :grid1, :grid2
    attr_reader :winner

    def initialize(player1, war_room1, player2, war_room2)
      @player1 = player1
      @war_room1 = war_room1
      @grid1 = Grid.new(@war_room1.sectors)
      @fleet1 = create_fleet

      @player2 = player2
      @war_room2 = war_room2
      @grid2 = Grid.new(@war_room2.sectors)
      @fleet2 = create_fleet

      @game_over = false;
    end

    def prepare
      place_ships_for(@fleet1, @grid1, @player1)
      place_ships_for(@fleet2, @grid2, @player2)
    end

    def play
      set_attacker(@player1)

      while !@game_over
        play_turn
        switch_turns
      end
    end

    def set_attacker(player)
      @current_attacker = player
      if @current_attacker == @player1
        @attacked_grid = @grid2
        @attacked_fleet = @fleet2
      else
        @attacked_grid = @grid1
        @attacked_fleet = @fleet1
      end
    end

    def play_turn
      target = @current_attacker.next_target
      ship = @attacked_grid[target]
      if ship
        ship.hit!
        if ship.sunk? && all_ships_sunk?(@attacked_fleet)
          declare_winner(@current_attacker)
        end
      end
    end

    private ###############################################

    def switch_turns
      @current_attacker == @player1 ? set_attacker(@player2) : set_attacker(@player1)
    end

    def all_ships_sunk?(fleet)
      return fleet.values.all? { |ship| ship.sunk? }
    end

    def declare_winner(player)
      @winner = player
      @game_over = true
    end

    def place_ships_for(fleet, grid, player)
      grid.place(fleet[:carrier], player.carrier_placement)
      grid.place(fleet[:battleship], player.battleship_placement)
      grid.place(fleet[:destroyer], player.destroyer_placement)
      grid.place(fleet[:submarine], player.submarine_placement)
      grid.place(fleet[:patrolship], player.patrolship_placement)
    end

    def create_fleet
      fleet = {}
      fleet[:carrier] = Carrier.new
      fleet[:battleship] = Battleship.new
      fleet[:destroyer] = Destroyer.new
      fleet[:submarine] = Submarine.new
      fleet[:patrolship] = Patrolship.new
      return fleet
    end

  end

end