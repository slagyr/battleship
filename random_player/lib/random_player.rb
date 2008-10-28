$: << File.expand_path(File.dirname(__FILE__) + "/../../battleship/lib")
require 'battleship/grid'
require 'battleship/mock_war_room'
require 'battleship/ship'

class RandomPlayer

  def name
	  return "Rear Admiral Randy" 
  end

  def new_game(opponent_name)
    find_valid_placements
    build_move_list
  end

  attr_reader :carrier_placement, :battleship_placement, :destroyer_placement, :submarine_placement, :patrolship_placement

  def next_target
    return @targets.shift
  end

  def target_result(coordinates, was_hit, ship_sunk)
  end

  def enemy_targeting(coordinates)
  end

  def game_over(result, disqualification_reason=nil)
  end

  private #################################################

  ROWS = %w{ A B C D E F G H I J }

  def random_row
    return ROWS[rand(10)]
  end

  def random_col
    return rand(10) + 1
  end

  def random_orientation
    return rand(2) == 0 ? "vertical" : "horizontal" 
  end

  def random_placement
    return "#{random_row}#{random_col} #{random_orientation}"
  end

  def find_valid_placements
    need_valid_placement = true
    attempts = 0
    while need_valid_placement
      attempts += 1
      begin
        create_random_placements
        attempt_placements
        need_valid_placement = false
      rescue Exception => e
        # ignore
#        puts "failed attempt ##{attempts} : #{e}"
      end
    end
  end

  def create_random_placements
    @carrier_placement = random_placement
    @battleship_placement = random_placement
    @destroyer_placement = random_placement
    @submarine_placement = random_placement
    @patrolship_placement = random_placement
  end

  def attempt_placements
    grid = Battleship::Grid.new(Battleship::MockSectors.new)
    grid.place(Battleship::Carrier.new, @carrier_placement)
    grid.place(Battleship::Battleship.new, @battleship_placement)
    grid.place(Battleship::Destroyer.new, @destroyer_placement)
    grid.place(Battleship::Submarine.new, @submarine_placement)
    grid.place(Battleship::Patrolship.new, @patrolship_placement)
  end

  def build_move_list   
    moves = []
    ROWS.each do |row|
      (1..10).each do |col|
        moves << ["#{row}#{col}", rand(10000)]
      end
    end
    moves.sort! { |a, b| a[1] <=> b[1] }
    @targets = moves.collect { |move| move[0] }
  end

end