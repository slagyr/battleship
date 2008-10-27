require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/simple_player'

describe Battleship::SimplePlayer do

  before(:each) do
    @player = Battleship::SimplePlayer.new
  end

  it "should start a new game" do
    @player.new_game("Opponent's Name")

    @player.opponent.should == "Opponent's Name"
  end

  it "should place ships simply" do
    @player.carrier_placement.should == "A1 horizontal"
    @player.battleship_placement.should == "B1 horizontal"
    @player.destroyer_placement.should == "C1 horizontal"
    @player.submarine_placement.should == "D1 horizontal"
    @player.patrolship_placement.should == "E1 horizontal"
  end

  it "should fire in a simple pattern" do
    @player.next_target.should == "A1"
    @player.next_target.should == "A2"
    @player.next_target.should == "A3"
    96.times { @player.next_target }
    @player.next_target.should == "J10"
  end



end