require 'battleship/placement_statemachine'

module Battleship

  class HumanPlayer

    attr_accessor :my_war_room, :opponent_war_room, :grid

    def new_game(opponent_name)
      @opponent = opponent_name
      reset
    end

    def carrier_placement
      return ship_placement(@my_war_room.ship_statuses[:carrier], 5)
    end

    def battleship_placement
      return ship_placement(@my_war_room.ship_statuses[:battleship], 4)
    end

    def destroyer_placement
      return ship_placement(@my_war_room.ship_statuses[:destroyer], 3)
    end

    def submarine_placement
      return ship_placement(@my_war_room.ship_statuses[:submarine], 3)
    end

    def patrolship_placement
      return ship_placement(@my_war_room.ship_statuses[:patrolship], 2)
    end

    def next_target
      target = target_for_current_shot
      @shots_taken += 1
      return target
    end

    def target_result(coordinates, was_hit, ship_sunk)
      @targets[coordinates] = [was_hit, ship_sunk]
    end

    def enemy_targeting(coordinates)
      @enemy_targeted_sectors << coordinates
    end

    def game_over(result, disqualification_reason=nil)
      @result = result
      @disqualification_reason = disqualification_reason
    end

    # Non API methods #####################################

    attr_reader :opponent, :targets, :enemy_targeted_sectors, :result, :disqualification_reason #:nodoc:

    def initialize #:nodoc:
      @targets = {}
      @enemy_targeted_sectors = []
      reset
    end

    private ###############################################

    def reset
      @shots_taken = 0
    end

    ROWS = %w{ A B C D E F G H I J }

    def target_for_current_shot
      row = ROWS[(@shots_taken) / 10]
      col = @shots_taken % 10 + 1
      return "#{row}#{col}"
    end

    def get_placement(length)
      statemachine = PlacementStatemachine.instance
      statemachine.context.reset(@my_war_room.sectors, @grid, length)
      @my_war_room.sectors.statemachine = statemachine

      while statemachine.context.placement.nil?
        sleep(0.1)
      end

      @my_war_room.sectors.statemachine = nil
      return statemachine.context.placement
    end

    def ship_placement(status_ui, length)
      status_ui.blink
      placement = get_placement(length)
      status_ui.stop_blinking
      return placement
    end

  end

end