require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/placement_statemachine'
require 'battleship/grid'
require 'battleship/mock_war_room'
require 'battleship/ship'

describe Battleship::PlacementStatemachine do

  before(:each) do
    @statemachine = Battleship::PlacementStatemachine.instance
    @context = @statemachine.context
    @war_room = Battleship::MockWarRoom.new
    @sectors = @war_room.sectors
    @sector = @sectors.children[0]
    @grid = Battleship::Grid.new(@war_room)

    @context.reset(@sectors, @grid, 5)
  end

  it "should highlight a sector" do
    @sector.should_receive(:highlight)

    @context.highlight_sector(@sector)
  end

  it "should attemp to anchor, invalid" do
    @grid.place(Battleship::Carrier.new, "A1 horizontal")
    @sector.should_receive(:coordinates).and_return("A3")
    @statemachine.should_receive(:invalid_anchor)

    @context.attempt_anchor(@sector)
  end

  it "should attemp to anchor, valid" do
    @sector.should_receive(:coordinates).and_return("A3")
    @statemachine.should_receive(:valid_anchor)

    @context.attempt_anchor(@sector)
  end

  it "should place a ship" do
    @context.reset(@sectors, @grid, 5)

    @statemachine.click(@sectors.children[0])
    @statemachine.hover(@sectors.children[9])
    @statemachine.click(@sectors.children[8])

    @context.placement.should == "A1 horizontal"
  end
  
end