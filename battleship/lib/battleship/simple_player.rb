module Battleship

  # Battleship Player
  #
  # Battleship is board game between two players.  See http://en.wikipedia.org/wiki/Battleship for more information and
  # game rules.
  #
  # A player represents the conputer AI to play a game of Battleship.  It should know how to place ships and target
  # the opponents ships.
  #
  # This version of Battleship is played on a 10 x 10 grid where rows are labled by the letters A - J and
  # columns are labled by the numbers 1 - 10.  At the start of the game, each player will be asked for ship placements.
  # Once the ships are placed, play proceeeds by each player targeting one square on their opponents map.  A player
  # may only target one square, reguardless of whether it resulted in a hit or not, before changing turns with her opponent.
  #
  class SimplePlayer

    # Returns the name of the player.  Every player must have a name that does not change.
    # Choose a unique name so as not to conflict with other players.
    #
    def name
      return @name
    end

    # This method is called at the beginning of each game.  A player may only be instantiated once and used to play many games.
    # So new_game should reset any internal state acquired in previous games so that it is prepared for a new game.
    #
    # The name of the opponent player is passed in.  This allows for the possibility to learn opponent strategy and
    # play the game differently based on the opponent.
    #
    def new_game(opponent_name)
      @opponent = opponent_name
      reset
    end

    # Returns the placement of the carrier. A carrier consumes 5 squares.
    #
    # The return value is a string that describes the placements of the ship.
    # The placement string must be in the following format:
    #
    #   "#{ROW}#{COL} #{ORIENTATION}"
    #
    # eg
    #
    #   A1 horizontal # the ship will occupy A1, A2, A3, A4, and A5
    #   A1 vertical # the ship will occupy A1, B1, C1, D1, and E1
    #   F5 horizontal # the ship will occupy F5, F6, F7, F8, and F9
    #   F5 vertical # the ship will occupy F5, G5, H5, I5, and J5
    #
    # The ship must not fall off the edge of the map.  For example, a carrier placement of 'A8 horizontal' would
    # not leave enough space in the A row to accomidate the carrier since it requires 5 squares.
    #
    # Ships may not overlap with other ships.  For example a carrier placement of 'A1 horizontal' and a submarine
    # placement of 'A1 vertical' would be invalid because bothe ships are trying to occupy the square A1.
    #
    # Invalid ship placements will result in disqualification of the player.
    #
    def carrier_placement
      return "A1 horizontal"
    end

    # Returns the placement of the battleship. A battleship consumes 4 squares.
    #
    # See carrier_placement for details on ship placement
    #
    def battleship_placement
      return "B1 horizontal"
    end

    # Returns the placement of the destroyer. A destroyer consumes 3 squares.
    #
    # See carrier_placement for details on ship placement
    #
    def destroyer_placement
      return "C1 horizontal"
    end

    # Returns the placement of the submarine. A submarine consumes 3 squares.  
    #
    # See carrier_placement for details on ship placement
    #
    def submarine_placement
      return "D1 horizontal"
    end

    # Returns the placement of the patrolship. A patrolship consumes 2 squares.
    #
    # See carrier_placement for details on ship placement
    #
    def patrolship_placement
      return "E1 horizontal"
    end

    # Returns the coordinates of the players next target.  This method will be called once per turn.  The player
    # should return target coordinates as a string in the form of:
    #
    #   "#{ROW}#{COL}"
    #
    # eg
    #
    #   A1 # the square in Row A and Column 1
    #   F5 # the square in Row F and Column 5
    #
    # Since the map contains only 10 rows and 10 columns, the ROW should be A, B, C, D, E, F, G H, I, or J. And the
    # COL should be 1, 2, 3, 4, 5, 6, 7, 8, 9, or 10
    #
    # Returning coordinates outside the range or in an invalid format will result in the players disqualification.
    #
    # It is illegal to illegal to target a sector more than once.  Doing so will also result in disqualification.
    #
    def next_target
      target = target_for_current_shot
      @shots_taken += 1
      return target
    end

    # target_result will be called by the system after a call to next_target.  The paramters supplied inform the player
    # of the results of the target.
    #
    #   coordinates : string. The coordinates targeted.  It will be the same value returned by the previous call to next_target
    #   was_hit     : boolean.  true if the target was occupied by a ship.  false otherwise.
    #   ship_sunk   : symbol.  nil if the target did not result in the sinking of a ship.  If the target did result in
    #     in the sinking of a ship, the ship type is supplied (:carrier, :battleship, :destroyer, :submarine, :patrolship).
    #
    # An intelligent player will use the information to better play the game.  For example, if the result indicates a
    # hit, a player my choose to target neighboring squares to hit and sink the remainder of the ship.
    #
    def target_result(coordinates, was_hit, ship_sunk)
      @targets[coordinates] = [was_hit, ship_sunk]
    end

    # enemy_targeting is called by the system to inform a player of their apponents move.  When the opponent targets
    # a square, this method is called with the coordinates.
    #
    # Players may use this information to understand an opponents targeting strategy and place ships differently
    # in subsequent games.
    #
    def enemy_targeting(coordinates)
      @enemy_targeted_sectors << coordinates
    end

    # Called by the system at the end of a game to inform the player of the results.
    #
    #   result  : 1 of 3 possible values (:victory, :defeate, :disqualified)
    #   disqualification_reason : nil unless the game ended as the result of a disqualification.  In the event of a
    #     disqualification, this paramter will hold a string description of the reason for disqualification.  Both
    #     players will be informed of the reason.
    #
    #   :victory # indicates the player won the game
    #   :defeat # indicates the player lost the game
    #   :disqualified # indicates the player was disqualified
    #
    def game_over(result, disqualification_reason=nil)
      @result = result
      @disqualification_reason = disqualification_reason
    end

    # Non API methods #####################################

    attr_reader :opponent, :targets, :enemy_targeted_sectors, :result, :disqualification_reason #:nodoc:

    def initialize(name="SimplePlayer") #:nodoc:
      @name = name
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

  end

end