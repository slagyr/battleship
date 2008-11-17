require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/human_player'
require 'battleship/mock_war_room'

describe Battleship::HumanPlayer do

  before(:each) do
    @my_war_room = Battleship::MockWarRoom.new
    @opponent_war_room = Battleship::MockWarRoom.new

    @player = Battleship::HumanPlayer.new
    @player.my_war_room = @my_war_room
    @player.opponent_war_room = @opponent_war_room
  end

  it "should have a new grid for a new game" do
    @player.new_game("blah")

    @opponent_war_room.concealed?.should == true
    @player.grid.should_not == nil
  end

  def sector(coords)
    @my_war_room.sectors.children.each do |sector|
      return sector if sector.coordinates == coords
    end
  end

  it "should place a ship" do
    @player.new_game("blah")
    thread = Thread.new { @player.carrier_placement }
    sleep(0.01)

    @player.sector_clicked(sector("A1"))
    @player.sector_clicked(sector("B1"))

    thread.join

    @player.grid["C1"].ship.name.should == "carrier"
  end

  it "should record targeted sectors" do
    @player.new_game("blah")
    thread = Thread.new { @player.next_target }
    sleep(0.01)

    @player.sector_clicked(sector("A1"))

    thread.join
    @player.grid["A1"].attacked.should == true
  end

  it "should not allow human to target same sector twice" do
    @player.new_game("blah")
    thread = Thread.new { @player.next_target }
    sleep(0.01)
    @player.sector_clicked(sector("A1"))
    thread.join

    @result = nil
    thread = Thread.new { @result = @player.next_target }
    sleep(0.01)
    @player.sector_clicked(sector("A1"))
    sleep(0.2)
    @player.sector_clicked(sector("B1"))
    thread.join

    @result.should == "B1"
    @player.grid["A1"].attacked.should == true
    @player.grid["B1"].attacked.should == true
  end

end