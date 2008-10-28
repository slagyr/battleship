require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'random_player'

describe RandomPlayer do

  before(:each) do
    @randy = RandomPlayer.new
  end

  it "should find valid ship placements" do
    @randy.new_game("Captain Katie")

    grid = Battleship::Grid.new(Battleship::MockSectors.new)
    lambda do
      grid.place(Battleship::Carrier.new, @randy.carrier_placement)
      grid.place(Battleship::Battleship.new, @randy.battleship_placement)
      grid.place(Battleship::Destroyer.new, @randy.destroyer_placement)
      grid.place(Battleship::Submarine.new, @randy.submarine_placement)
      grid.place(Battleship::Patrolship.new, @randy.patrolship_placement)
    end.should_not raise_error
  end

  it "should have a random move list" do
    @randy.new_game("Captain Katie")

    targets = []
    100.times do
      target = @randy.next_target
      targets.should_not include(target)
      targets << target
    end
    targets.sort.should_not == targets
  end

end