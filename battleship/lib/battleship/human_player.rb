require 'battleship/placement_statemachine'

module Battleship

  class HumanPlayer

    attr_accessor :my_war_room, :opponent_war_room, :grid

    def new_game(opponent_name)
      opponent_war_room.sectors.ships_hidden = true
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
      @target_desired = true
      @opponent_war_room.blink
      @opponent_war_room.sectors.sector_listener = self
      sleep(0.1) while @target.nil?
      @opponent_war_room.sectors.sector_listener = nil
      target = @target
      @target_desired = false
      @target = nil
      @opponent_war_room.stop_blinking
      return target
    end

    def target_result(coordinates, was_hit, ship_sunk)
    end

    def enemy_targeting(coordinates)
    end

    def game_over(result, disqualification_reason=nil)
    end

    # Non API methods #####################################

    def initialize #:nodoc:
    end
    
    def sector_clicked(sector)
      if @target_desired
        @target = sector.coordinates
      elsif @statemachine
        @statemachine.click(sector)
      end 
    end

    def sector_entered(sector)
      if @target_desired
        @hovered_sector.unhighlight if @hovered_sector
        @hovered_sector = sector
        @hovered_sector.highlight
      elsif @statemachine
        @statemachine.hover(sector)
      end
    end

    private ###############################################

    def get_placement(length)
      @statemachine = PlacementStatemachine.instance
      @statemachine.context.reset(@my_war_room.sectors, @grid, length)
      @my_war_room.sectors.sector_listener = self

      while @statemachine.context.placement.nil?
        sleep(0.1)
      end

      @my_war_room.sectors.sector_listener = nil
      placement = @statemachine.context.placement
      @statemachine = nil
      return placement
    end

    def ship_placement(status_ui, length)
      status_ui.blink
      placement = get_placement(length)
      status_ui.stop_blinking
      return placement
    end


  end

end