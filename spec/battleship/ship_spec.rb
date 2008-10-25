require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'battleship/ship'

describe Battleship::Ship do

  it "should construct a carrier" do
    carrier = Battleship::Carrier.new

    carrier.length.should == 5
    carrier.name.should == "carrier"
  end

  it "should construct a battleship" do
    battleship = Battleship::Battleship.new

    battleship.length.should == 4
    battleship.name.should == "battleship"
  end

  it "should construct a destroyer" do
    destroyer = Battleship::Destroyer.new

    destroyer.length.should == 3
    destroyer.name.should == "destroyer"
  end

  it "should construct a submarine" do
    submarine = Battleship::Submarine.new

    submarine.length.should == 3
    submarine.name.should == "submarine"
  end

  it "should construct a patrolship" do
    patrolship = Battleship::Patrolship.new

    patrolship.length.should == 2
    patrolship.name.should == "patrolship"
  end

  it "should know when a destroyer is sunk" do
    ship = Battleship::Destroyer.new

    3.times do
      ship.sunk?.should == false
      ship.hit!
    end

    ship.sunk?.should == true
  end

  it "should know when a carrier is sunk" do
    ship = Battleship::Carrier.new

    5.times do
      ship.sunk?.should == false
      ship.hit!
    end

    ship.sunk?.should == true
  end



end