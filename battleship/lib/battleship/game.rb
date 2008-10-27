require 'battleship/grid'
require 'battleship/ship'

module Battleship

  class Game

    attr_reader :player1, :player2
    attr_reader :war_room1, :war_room2
    attr_reader :fleet1, :fleet2
    attr_reader :grid1, :grid2
    attr_reader :winner, :disqualification_reason

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
      @war_room1.commander = @player1.name
      @war_room2.commander = @player2.name
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

    private ###############################################

    def play_turn
      target = @current_attacker.next_target
      begin
        process_target(target)
      rescue BattleshipException => e
        disqualify(@current_attacker, "The player targeted an invalid sector.  #{e.message}.")
      end
    end

    def process_target(target)
      ship = @attacked_grid.attack(target)
      @attacked_player.enemy_targeting(target)
      if ship
        process_hit(ship, target)
      else
        @current_attacker.target_result(target, false, nil)
      end
    end

    def process_hit(ship, target)
      ship.hit!
      @attacked_war_room.ship_statuses[ship.name.to_sym].damaged(ship.damage)
      if ship.sunk?
        @current_attacker.target_result(target, true, ship.name.to_sym)
        if all_ships_sunk?(@attacked_fleet)
          declare_winner(@current_attacker)
        end
      else
        @current_attacker.target_result(target, true, nil)
      end
    end

    def switch_turns
      @current_attacker == @player1 ? set_attacker(@player2) : set_attacker(@player1)
    end

    def set_attacker(player)
      @current_attacker = player
      if @current_attacker == @player1
        @attacked_player = @player2
        @attacked_grid = @grid2
        @attacked_fleet = @fleet2
        @attacked_war_room = @war_room2
      else
        @attacked_player = @player1
        @attacked_grid = @grid1
        @attacked_fleet = @fleet1
        @attacked_war_room = @war_room1
      end
    end

    def all_ships_sunk?(fleet)
      return fleet.values.all? { |ship| ship.sunk? }
    end

    def declare_winner(player)
      @winner = player
      @game_over = true
      if @winner == @player1
        @war_room1.victory!
        @player1.game_over(:victory)
        @war_room2.defeat!
        @player2.game_over(:defeat)
      else
        @war_room1.defeat!
        @war_room2.victory!
      end
    end

    def disqualify(player, reason)
      @game_over = true
      if (player == @player1)
        @winner = @player2
        @war_room1.disqualified!(reason)
        @player1.game_over(:disqualified, reason)
        @war_room2.victory!
        @player2.game_over(:victory, reason)
      else
        @winner = @player1
        @war_room1.victory!
        @player1.game_over(:victory, reason)
        @war_room2.disqualified!(reason)
        @player2.game_over(:disqualified, reason)
      end
      @disqualification_reason = reason
    end

    def place_ships_for(fleet, grid, player)
      begin
        grid.place(fleet[:carrier], player.carrier_placement)
        grid.place(fleet[:battleship], player.battleship_placement)
        grid.place(fleet[:destroyer], player.destroyer_placement)
        grid.place(fleet[:submarine], player.submarine_placement)
        grid.place(fleet[:patrolship], player.patrolship_placement)
      rescue BattleshipException => e
        disqualify(player, "The player made an invalid ship placement.  #{e.message}.")
      end
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