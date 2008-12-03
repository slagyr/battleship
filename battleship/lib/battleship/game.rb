require 'battleship/grid'
require 'battleship/ship'
require 'battleship/human_player'

module Battleship

  class Game

    attr_reader :player1, :player2, :player1_name, :player2_name
    attr_reader :war_room1, :war_room2
    attr_reader :fleet1, :fleet2
    attr_reader :grid1, :grid2
    attr_reader :winner, :disqualification_reason
    attr_accessor :max_move_duration
    attr_reader :player1_placements, :player2_placements
    attr_reader :player1_targets, :player2_targets

    def initialize(player1_name, player1, war_room1, player2_name, player2, war_room2)
      @max_move_duration = 5

      @player1_name = player1_name
      @player1 = player1
      @war_room1 = war_room1
      @player1_placements = {}
      @player1_targets = []
      @grid1 = Grid.new(@war_room1.sectors)
      @fleet1 = create_fleet

      @player2_name = player2_name
      @player2 = player2
      @war_room2 = war_room2
      @player2_placements = {}
      @player2_targets = []
      @grid2 = Grid.new(@war_room2.sectors)
      @fleet2 = create_fleet

      @game_over = false;
    end

    def prepare
      @war_room1.commander = @player1_name
      @war_room2.commander = @player2_name
      handle_human_players
      @player1.new_game(@player2_name)
      @player2.new_game(@player1_name)
      place_ships_for(@fleet1, @grid1, @player1, @player1_placements)
      place_ships_for(@fleet2, @grid2, @player2, @player2_placements)
    end

    def play
      set_attacker(@player1)

      while !@game_over
        play_turn
        switch_turns
      end
    end

    def player1_winner?
      return @winner == @player1
    end

    def to_hash
      hash = {}
      hash[:player1] = @player1_name
      hash[:player2] = @player2_name
      hash[:winner] = winners_name 
      hash[:disqualification_reason] = @disqualification_reason
      hash[:player1_placements] = @player1_placements
      hash[:player2_placements] = @player2_placements
      hash[:player1_targets] = @player1_targets
      hash[:player2_targets] = @player2_targets
      return hash
    end

    private ###############################################

    def play_turn
      target = get_next_target
      return if target.nil?
      begin
        @target_list << target
        process_target(target)
      rescue BattleshipException => e
        disqualify(@current_attacker, "The player targeted an invalid sector.  #{e.message}.")
      end
    end

    def get_next_target
      @target = nil
      thread = Thread.new { @target = @current_attacker.next_target }
      result = thread.join(@max_move_duration)
      if result.nil?
        thread.kill
        disqualify(@current_attacker, "The player took too long to respond") if result.nil?
      end
      return @target
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
        @target_list = @player1_targets
      else
        @attacked_player = @player1
        @attacked_grid = @grid1
        @attacked_fleet = @fleet1
        @attacked_war_room = @war_room1
        @target_list = @player2_targets
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

    def place_ships_for(fleet, grid, player, placements)
      thread = Thread.new do
        placements[:carrier] = player.carrier_placement
        placements[:battleship] = player.battleship_placement
        placements[:destroyer] = player.destroyer_placement
        placements[:submarine] = player.submarine_placement
        placements[:patrolship] = player.patrolship_placement
      end
      result = thread.join(@max_move_duration * 5)
      if result.nil?
        thread.kill
        disqualify(player, "The player took too long to respond")
        return
      end

      begin
        [:carrier, :battleship, :destroyer, :submarine, :patrolship].each do |ship_type|
          grid.place(fleet[ship_type], placements[ship_type])
        end
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

    def handle_human_players
      if @player1.class == HumanPlayer
        @player1.my_war_room = @war_room1
        @player1.opponent_war_room = @war_room2
      end
      if @player2.class == HumanPlayer
        @player2.my_war_room = @war_room2
        @player2.opponent_war_room = @war_room1
      end
    end

    def winners_name
      return nil if @winner.nil?
      if player1_winner?
        return player1_name
      else
        return player2_name
      end
    end

  end

end