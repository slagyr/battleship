module SergeantSimple
  class SergeantSimple

    def name
      return "Sergeant Simple"
    end

    def new_game(opponent_name)
      reset
    end

    def carrier_placement
      return "A1 horizontal"
    end

    def battleship_placement
      return "B1 horizontal"
    end

    def destroyer_placement
      return "C1 horizontal"
    end

    def submarine_placement
      return "D1 horizontal"
    end

    def patrolship_placement
      return "E1 horizontal"
    end

    def next_target
      target = target_for_current_shot
      @shots_taken += 1
      return target
    end

    def target_result(coordinates, was_hit, ship_sunk)
    end

    def enemy_targeting(coordinates)
    end

    def game_over(result, disqualification_reason=nil)
    end

    # Non API methods #####################################

    attr_reader :targets, :enemy_targeted_sectors

    def initialize
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

  end

end