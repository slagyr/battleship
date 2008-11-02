require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'rear_admiral_randy/rear_admiral_randy'

describe RearAdmiralRandy::RearAdmiralRandy do

  before(:each) do
    @randy = RearAdmiralRandy::RearAdmiralRandy.new
  end

  it "should find valid ship placements" do
    @randy.new_game("Captain Katie")

    grid = RearAdmiralRandy::Grid.new
    lambda do
      grid.place(RearAdmiralRandy::Ship.new(5), @randy.carrier_placement)
      grid.place(RearAdmiralRandy::Ship.new(4), @randy.battleship_placement)
      grid.place(RearAdmiralRandy::Ship.new(3), @randy.destroyer_placement)
      grid.place(RearAdmiralRandy::Ship.new(3), @randy.submarine_placement)
      grid.place(RearAdmiralRandy::Ship.new(2), @randy.patrolship_placement)
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