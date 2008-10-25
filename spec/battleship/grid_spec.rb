require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/grid'
require 'battleship/ship'

describe Battleship::Grid do

  before(:each) do
    @grid = Battleship::Grid.new
    @carrier = Battleship::Carrier.new
    @patrolship = Battleship::Patrolship.new
  end

  it "should place a horizontal carrier" do
    @grid.place(@carrier, "A1 horizontal")

    @grid["A1"].should == @carrier
    @grid["A2"].should == @carrier
    @grid["A3"].should == @carrier
    @grid["A4"].should == @carrier
    @grid["A5"].should == @carrier
  end

  it "should place a vertical carrier" do
    @grid.place(@carrier, "A1 vertical")

    @grid["A1"].should == @carrier
    @grid["B1"].should == @carrier
    @grid["C1"].should == @carrier
    @grid["D1"].should == @carrier
    @grid["E1"].should == @carrier
  end

  it "should place a horizontal patrolship" do
    @grid.place(@patrolship, "A1 horizontal")

    @grid["A1"].should == @patrolship
    @grid["A2"].should == @patrolship
    @grid["A3"].should == nil
  end

  it "should place a vertical carrier" do
    @grid.place(@patrolship, "A1 vertical")

    @grid["A1"].should == @patrolship
    @grid["B1"].should == @patrolship
    @grid["C1"].should == nil
  end

  it "should raise an exception with invalid placements" do
    lambda { @grid.place(@patrolship, "A0 vertical") }.should raise_error(Battleship::InvalidPlacementFormatException, "Invalid placement format: A0 vertical")
    lambda { @grid.place(@patrolship, "K9 vertical") }.should raise_error(Battleship::InvalidPlacementFormatException, "Invalid placement format: K9 vertical")
    lambda { @grid.place(@patrolship, "A1 sideways") }.should raise_error(Battleship::InvalidPlacementFormatException, "Invalid placement format: A1 sideways")
  end

  it "should not be able to place ships going off the grid" do
    lambda { @grid.place(@carrier, "A10 horizontal") }.should raise_error(Battleship::InvalidPlacementException, "A10 horizontal: The carrier would fall off the edge")
    @grid.clear
    lambda { @grid.place(@carrier, "A9 horizontal") }.should raise_error(Battleship::InvalidPlacementException, "A9 horizontal: The carrier would fall off the edge")
    @grid.clear
    lambda { @grid.place(@carrier, "A8 horizontal") }.should raise_error(Battleship::InvalidPlacementException, "A8 horizontal: The carrier would fall off the edge")
    @grid.clear
    lambda { @grid.place(@carrier, "A7 horizontal") }.should raise_error(Battleship::InvalidPlacementException, "A7 horizontal: The carrier would fall off the edge")
    @grid.clear

    lambda { @grid.place(@carrier, "J1 vertical") }.should raise_error(Battleship::InvalidPlacementException, "J1 vertical: The carrier would fall off the edge")
    @grid.clear
    lambda { @grid.place(@carrier, "I1 vertical") }.should raise_error(Battleship::InvalidPlacementException, "I1 vertical: The carrier would fall off the edge")
    @grid.clear
    lambda { @grid.place(@carrier, "H1 vertical") }.should raise_error(Battleship::InvalidPlacementException, "H1 vertical: The carrier would fall off the edge")
    @grid.clear
    lambda { @grid.place(@carrier, "G1 vertical") }.should raise_error(Battleship::InvalidPlacementException, "G1 vertical: The carrier would fall off the edge")
  end

  it "should not place ships on top of eachother" do
    @grid.place(@carrier, "E3 Horizontal")

    lambda { @grid.place(@patrolship, "E3 Horizontal") }.should raise_error(Battleship::InvalidPlacementException, "E3 Horizontal: The patrolship would overlap the carrier")
    lambda { @grid.place(@patrolship, "E7 Horizontal") }.should raise_error(Battleship::InvalidPlacementException, "E7 Horizontal: The patrolship would overlap the carrier")
    lambda { @grid.place(@patrolship, "E3 Vertical") }.should raise_error(Battleship::InvalidPlacementException, "E3 Vertical: The patrolship would overlap the carrier")
    lambda { @grid.place(@patrolship, "E5 Vertical") }.should raise_error(Battleship::InvalidPlacementException, "E5 Vertical: The patrolship would overlap the carrier")
  end

end
